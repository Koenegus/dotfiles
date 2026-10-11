# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1 red white white

setopt histignorealldups sharehistory
setopt appendhistory
setopt extendedhistory
setopt histignoredups

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit -d ~/.zcompdump

eval "$(fzf --zsh)"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#alias
alias ff='fastfetch -l small'
alias qprun='doas jexec -u ivan admixlab /home/ivan/Documents/qpAdm/gui/start.sh'
alias qpgui='surf http://127.0.1.1:8501/ &'
alias doas='doas '
alias mal='python3 /home/ivan/Scripts/mal.py'
alias netsurf='netsurf-gtk duckduckgo.com'
alias ciao='ping 192.168.1.103'
alias prismlauncher='/home/ivan/Ports/PrismLauncher-Cracked/build/prismlauncher'
#alias :re='doas service netif restart wlan0'
alias :re='/home/ivan/Scripts/wifibox.sh'
alias :eth='doas service netif restart em0'
alias www='doas jexec -u ivan browsers librewolf'
alias librewolf='doas jexec -u ivan browsers librewolf'
alias chrome='doas jexec -u ivan browsers chrome'
alias tor-browser='doas jexec -u ivan browsers tor-browser'
alias android='/home/ivan/Scripts/android.sh'
alias android_stop='/home/ivan/Scripts/android_stop.sh'
alias mpvs='mpv --no-audio-display --input-ipc-server=/tmp/mpv.sock'
alias reboot='doas shutdown -r now'
alias pkg-size='pkg info -as | sort -k 2 -h | tail -20 | column -t'
alias fastboot-at='/usr/local/bin/fastboot'
alias ls="eza --icons --group-directories-first"
alias cls="clear"
alias bat="apm"
alias poweroff='/home/ivan/Scripts/poweroff.sh'
alias xterm='xterm -bg black -fg white -fa "JetBrainsMono Nerd Font" -fs 10 tmux'
alias pgadmin4='librewolf http://10.0.1.2:5050'
alias brmodelo='/home/ivan/Scripts/brmodelo.sh'
alias captura='nomacs /home/ivan/Pictures/Screenshots/2026 &'
alias wine32='WINEPREFIX="/home/ivan/.wine32" wine '
alias wine64='WINEPREFIX="/home/ivan/.wine" wine '
alias handbook='zathura /home/ivan/Documents/FreeBSD/handbook_en.pdf'
alias ppo='/home/ivan/Scripts/pkg_rinfo.sh'
alias ports-update='/home/ivan/Scripts/ports-update.sh'
alias radio='/home/ivan/Scripts/radio.sh'
alias proton='/usr/local/wine-proton/bin-wow64/wine'
alias fm='nnn -e'
alias tempo='doas ntpdate pool.ntp.org'
alias dotfiles='/usr/local/bin/git --git-dir=/home/ivan/.dotfiles --work-tree=/home/ivan'
alias fbsdinfo='/home/ivan/Scripts/system_info.sh'
alias st='st -f 'JetBrainsMonoNerdFont:size=10' -e tmux'
#alias microjava='/usr/local/bin/git --git-dir=/home/ivan/.micropolis-refurbished --work-tree=/home/ivan'
alias stress-nigga='stress-ng --vm 1 --vm-bytes 12G --vm-keep --timeout 5m'
alias code='code-oss'
alias twitter='surf 'x.com''

#######
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
setopt INTERACTIVE_COMMENTS
export EDITOR=nvim

#JAVA
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dsun.java1d.xrender=true"

# Enforce UTF-8 locale in environment variables
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

vedere() {
    local interval=2

    if [ "$1" = "-n" ]; then
        interval="$2"
        shift 2
    fi

    while true; do
        clear
        "$@"
        sleep "$interval"
    done
}

ip() {
    case ${1} in
      (r)
        netstat -Wrn -f inet \
          | grep -A 256 '^Destination' \
          | awk '{printf("%20s  %-18s  %18s  %-7s\n", $1, $2, $4, $3)}'
          ;;
      (l)
        netstat -Win -f link \
          | awk '{printf("%20s  %-18s  %18s  %-7s\n", $1, $4, $3, $2)}'
          ;;
      (a|*)
        netstat -Win -f inet \
          | awk '{printf("%20s  %-18s  %18s  %-7s\n", $1, $4, $3, $2)}'
          ;;
    esac
}

ports-log() {
    awk '/^=== SUMMARY ===$/ {buf=""; on=1; next} on && /^===/ {on=0} on {buf = buf $0 "\n"} END {printf "%s", buf}' /var/log/update-ports.log
}

dotsync() {
    dotfiles add "$@"
    dotfiles commit -m "Update: $*"
    dotfiles push
}

dotremove() {
    dotfiles rm --cached "$@"
    dotfiles commit -m "Remove: $*"
    dotfiles push
}

py3() {
    /usr/local/bin/python3 "$@" 2>/dev/null
}
