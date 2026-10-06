#!/bin/sh
# Updates programs with local modifications through ports and keeps them locked
# in pkg, so "pkg upgrade" does not replace them with the binary package.
#
# Run as root (root's crontab, or "doas/sudo ./update-ports.sh").
# Usage: update-ports.sh [-f]     -f = rebuild even without a new version
#                                      (use after changing patch/Makefile.local)

PORTSDIR=/usr/ports
PORTS="x11-fm/thunar x11-wm/openbox x11/sterm emulators/mgba x11-servers/xlibre-server"
LOG=/var/log/update-ports.log

FORCE=0
[ "${1:-}" = "-f" ] && FORCE=1

exec 3>&1
exec >>"$LOG" 2>&1
INICIO=$(wc -l < "$LOG")
echo "=== $(date '+%F %T') ==="

cd "$PORTSDIR" || exit 1
git pull --ff-only || { echo "git pull failed; aborting" >&3; exit 1; }

for port in $PORTS; do
    cd "$PORTSDIR/$port" || { echo "$port: directory does not exist"; continue; }
    name=$(make -V PKGBASE)    # package name (not always = directory name)

    novo=$(make -V PKGNAME)
    atual=$(pkg query '%n-%v' "$name")

    if [ "$FORCE" -eq 0 ] && [ "$novo" = "$atual" ]; then
        echo ">> $name: already at $atual, nothing to do"
        continue
    fi
    echo "$name: ${atual:-not installed} -> $novo"

    # 1) prepare and BUILD with the old version still installed.
    #    If it fails (patch does not apply, build error, etc.), nothing has been removed.
    make clean
    if ! { make BATCH=yes install-missing-packages && make BATCH=yes build; }; then
        echo ">> $name: FAILED before installation; old version kept"
        make clean
        continue
    fi

    # 2) only now replace it (deinstall + install, without rebuilding)
    pkg unlock -y "$name"

    if make BATCH=yes reinstall; then
        echo ">> $name: UPDATED ${atual:-none} -> $novo"
    else
        echo ">> $name: FAILED during reinstall"
    fi

    pkg lock -y "$name"      # lock again even if the reinstall failed

    make clean
done

echo "=== end ==="
RESUMO=$(tail -n +$((INICIO + 1)) "$LOG" | sed -n 's/^>> //p')
printf '=== SUMMARY ===\n%s\n' "$RESUMO"       
printf '=== SUMMARY ===\n%s\n' "$RESUMO" >&3    # term/cron
