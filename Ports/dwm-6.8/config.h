/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 2;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
#define ICONSIZE 12   /* icon size */
#define ICONSPACING 5 /* space between icon and title */
static const unsigned int systraypinning = 0;   /* 0: follows selected monitor, >0: pin to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* spacing between systray icons */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display on first monitor */
static const int showsystray = 1;               /* 0 means no systray */
/* NOTE: set to 0 to set to default (whitespace) */
static char outer_separator_beg      = '[';
static char outer_separator_end      = ']';
static char inner_separator          = ' ';
static unsigned truncate_icons_after = 2; /* will default to 1, that is the min */
static char truncate_symbol[]         = "...";
static const char *fonts[]          = { "JetBrainsMonoNerdFont:size=10" };
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#242f40";
static const char col_yellow[]	    = "#FFFF19";
static const char col_yellow2[]	    = "#f0c674";
static const char col_orange[]      = "#994a2b";
static const char col_brown[]	    = "#291d1d";
static const char col_purple[]      = "#6e72a5";
static const char col_darkpurple[]  = "#2c2d46";
static const char col_yellow3[]		= "#F3FF8A";
static const char col_red[]			= "#B22222";
static const char *colors[][4]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray4, col_brown, col_brown },
	[SchemeSel]  = { col_yellow3, col_red,  col_red },
};

/* tagging */
static const char *tags[] = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };

static const Rule rules[] = {
	/* class                          instance  title  tags mask  isfloating  monitor */
	{ "mGBA",                         NULL,     NULL,  0,         1,          -1 },
	{ "org.dosbox_staging.dosbox_staging", NULL, NULL, 0,         1,          -1 },
	{ "Snes9x-gtk",                   NULL,     NULL,  0,         1,          -1 },
	{ "pwcview",                      NULL,     NULL,  0,         1,          -1 },
	{ "lumina-calculator",            NULL,     NULL,  0,         1,          -1 },
	{ "micropolisj-Micropolis",       NULL,     NULL,  0,         1,          -1 },
	{ "fbsd-duckstation-qt",          NULL,     NULL,  0,         1,          -1 },
	{ "Netsurf-gtk",                  NULL,     NULL,  0,         1,          -1 },
	{ "XCalendar",                    NULL,     NULL,  0,         1,          -1 },
	{ "Java",                         NULL,     NULL,  0,         1,          -1 },
	{ "feh",                          NULL,     NULL,  0,         1,          -1 },
	{ "Xarchiver",                    NULL,     NULL,  0,         1,          -1 },
	{ "librewolf",                    NULL,     NULL,  1 << 1,    0,          -1 },
	{ "qutebrowser",                  NULL,     NULL,  1 << 1,    0,          -1 },
	{ "tor-browser",                  NULL,     NULL,  1 << 1,    0,          -1 },
	{ "mpv",                          NULL,     NULL,  1 << 4,    0,          -1 },
	{ "soffice.bin",                  NULL,     NULL,  1 << 3,    0,          -1 },
	{ "Claws-mail",                   NULL,     NULL,  1 << 5,    0,          -1 },
	{ "codium",                       NULL,     NULL,  1 << 6,    0,          -1 },
	{ "code-oss",                     NULL,     NULL,  1 << 6,    0,          -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }


/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu", NULL};
static const char *menucmd[] = { "/home/ivan/Scripts/dmenu.sh", NULL };
static const char *webcmd[] = { "doas", "jexec", "-u", "ivan", "browsers", "librewolf", NULL};
static const char *fmcmd[] = { "thunar", NULL};
static const char *officecmd[] = { "libreoffice", NULL};
static const char *mailcmd[] = { "claws-mail", NULL };
static const char *killcmd[] = { "xkill", NULL };
static const char *vol_up[]   = { "/home/ivan/Scripts/audio_up.sh", NULL };
static const char *vol_down[] = { "/home/ivan/Scripts/audio_down.sh", NULL };
static const char *vol_mute[] = { "/home/ivan/Scripts/audio_mute.sh", NULL };
static const char *bri_down[] = { "backlight", "decr", "5", NULL };
static const char *bri_up[]   = { "backlight", "incr", "5", NULL };
static const char *geanycmd[] = { "geany", NULL };
static const char *codecmd[] = {"/home/ivan/Ports/VSCodium/squashfs-root/bin/codium", "--no-sandbox", "--disable-gpu", "--no-zygote", "--in-process-gpu", "--font-render-hinting=non3", NULL};
static const char *editcmd[] = { "leafpad", NULL};
static const char *stcmd[] = { "/home/ivan/Scripts/term.sh", NULL };
static const char *lockcmd[] = { "slock", NULL};
static const char *zzzcmd[] = {"/home/ivan/Scripts/lock.sh", NULL};
static const char *printcmd[] = {"/home/ivan/Scripts/scrot.sh", NULL};
static const char *ptcmd[] = {"/home/ivan/Scripts/scrot_xclip.sh", NULL};
static const char *resizecmd[] = {"/home/ivan/Scripts/screen.sh", NULL};
static const char *pausecmd[] = {"/home/ivan/Scripts/mpv-command.py", "cycle", "pause", NULL};
static const char *skippycmd[] = {"skippy-xd", NULL};

static Key keys[] = { 
	/* modifier                     key        function        argument */
	{ MODKEY,						XK_r,      spawn,	  	   {.v = menucmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_u,      focusstack,     {.i = -1 } },
/*	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } }, */
/*	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } }, */
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_k,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_z, 	   zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,	                	XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_i,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_d,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,						XK_w,      spawn,	       {.v = webcmd } },
	{ MODKEY,						XK_f,      spawn,	       {.v = fmcmd } },
	{ MODKEY,						XK_c,      spawn,	       {.v = codecmd } },
	{ MODKEY,						XK_o,	   spawn,	       {.v = officecmd } },
	{ MODKEY,						XK_e,	   spawn,		   {.v = mailcmd } },
    { MODKEY,						XK_g,	   spawn,		   {.v = geanycmd } },
    { MODKEY,						XK_v,      spawn,		   {.v = editcmd } },
	{ MODKEY|ShiftMask,             XK_x,	   spawn,          {.v = killcmd } },
	{ MODKEY,						XK_Return, spawn,		   {.v = stcmd } },
	{ MODKEY,						XK_l,	   spawn,		   {.v = lockcmd } },
	{ MODKEY|ShiftMask,				XK_l,	   spawn,		   {.v = zzzcmd } },
	{ MODKEY,						XK_Print,  spawn,		   {.v = printcmd } },
	{ MODKEY|ShiftMask,				XK_Print,  spawn,		   {.v = ptcmd } },
    { MODKEY,                       XK_s,      spawn,          {.v = skippycmd }},
    { MODKEY|ShiftMask,             XK_s,      spawn,          {.v = resizecmd } },
    { MODKEY,                       XK_p,      spawn,          {.v = pausecmd }},
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_k,      quit,           {0} },
	{ 0, 0x1008ff11, spawn, {.v = vol_down } }, /* XF86AudioLowerVolume */
	{ 0, 0x1008ff13, spawn, {.v = vol_up   } }, /* XF86AudioRaiseVolume */
	{ 0, 0x1008ff12, spawn, {.v = vol_mute } }, /* XF86AudioMute */
	{ 0, 0x1008ff03, spawn, {.v = bri_down } }, /* XF86MonBrightnessDown */
	{ 0, 0x1008ff02, spawn, {.v = bri_up   } }, /* XF86MonBrightnessUp */
	{ MODKEY, XK_Left,  viewprev,  {0} },
	{ MODKEY, XK_Right, viewnext, {0} },
	{ MODKEY, XK_Down,  tagtoprev,  {0} },
	{ MODKEY, XK_Up, tagtonext, {0} },
	{ MODKEY,                       XK_a,      togglesticky,   {0} },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
//	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

