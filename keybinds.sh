#! /bin/bash

# less <<EOF
$PAGER <<EOF
Some of my keybindings.

Super is Mod4 aka the Windows key. This is the main key for navigating windows 
and performing global and desktop/monitor specific actions.

Super + Space is typically used as a 'leader' for more complex actions, such as
opening rofi/dmenu launchers and script runners.

Move around windows by using Super + hjkl. 

Some general mnemonics to remember:

  O = Open/Launch             |- Opens programs
  Q = Quit                    |- Kills windows and programs
  P = Previous                |- Emacs style history traversal
  N = Next                    |- Emacs style history traversal
  M = Maximize/Make           |- Typically a key for focusing or making 
                              |    a particular thing stand out

Other Things to consider
  Some keys (alt,tab,esc,ctrl) have hold/tap specific behaviour. This is do
  to the presence of Kmonad. Check the configs for different layers that are in
  use.

  I switched from using braces for local next/prev to a simpler 'U' and 'I', 
  since it is a very common action and the keys require less movement relative
  to the home row.

## General ####################################################################

  Super + Enter               |- Launch terminal (check TERMINAL sysvar)
  Super + O                   |- Application Launcher
  Super + Grave               |- Open Scratchpad terminal (same 
                              |    as TERMINAL sysvar)
  Super + b                   |- Open browser (check BROWSER sysvar)
  Super + shift + b           |- Open browser (from a list)
	    
## BSPWM ######################################################################

  Super + Shift + {direction} |- Swap window with {direction}
  Super + q                   |- Close window
  Super + f                   |- Toggle Floating Window
  Super + t                   |- Toggle Tiling Window
  Super + shift + t           |- Toggle Psuedo-Tiling Window
  Super + m                   |- Toggle Monocle Window
  Super + v                   |- Toggle Sticky Window
  Super + ,                   |- Toggle Single (re: Maximized) Window
  Super + /                   |- Toggle Hidden (re: Minimized) Window
  Super + y                   |- Unminimize first window in 
                              |    minimized stack
  Super + n/p                 |- Global window focus-swapping
  Super + u/i                 |- Local window focus-swapping
  Super + \ *                 |- Next desktop
  Super + Backspace           |- Previous desktop
  Super + ;                   |- Focus next monitor
  Super + 1-9                 |- Focus specific desktop
  Super + Shift + 1-9         |- Send focused window to specific desktop
  Super + g                   |- Promote focused
  Super + Shift + g           |- Demote focused
  Super + c + hjkl **         |- Cycle desktop
  Super + s + h/l             |- Send node to monitor one left or right
  Super + ctrl + hjkl         |- Move a floating window
  Super + ctrl + alt + hjkl   |- Move a floating window (faster)

  Resizing is complicated, so it get's its own section:

  Super + [                   |- If not root: Expand <-
  Super + ]                   |- If not root: Expand ->
  Super + Ctrl + [            |- If root: Expand <-
  Super + Ctrl + ]            |- If root: Expand ->

  Super + -                   |- If not bottom of screen: Contract upwards
  Super + =                   |- If not bottom of screen: Expand downwards
  Super + Ctrl + -            |- If bottom of screen: Expand updwards
  Super + Ctrl + =            |- If bottom of screen: Contract downwards

  Basically, [] is left and right and -= is up and down. If you are resizing
  the root node, hold control. If you are resizing the bottom-most node in a 
  stack, hold control.

  Note: like the floating window movement, add 'alt' to each binding to 
  expand/retract faster.

  ---

  * : this is technically Super + Shift + Tab, due to oem stuff
  **: behavior is slightly different between hl and jk - hl rotates the desktop
        and jk rotates the nodes

## i3 #########################################################################

  NOTE: a lot of the other bindings on this page *do not work* with i3 (yet).
    This is due to the fact that i3 handles hotkeys by itself, and almost all
    of my bindings are for sxhkd.

  Super + Shift + c           |- Reload i3 config
  Super + v                   |- Set next split to [V]ertical
  Super + b                   |- Set next split to [B]elow (horizontal)
  Super + e                   |- Toggle Split (Tiling)
  Super + s                   |- Toggle Stacked
  Super + t                   |- Toggle Tabbed
  Super + ,                   |- Toggle Fullscreen (maximized)
  Super + m                   |- Toggle Focus Mode
  Super + p                   |- Focus parent
  Super + n                   |- Focus child
  Super + [                   |- Shrink horizontally
  Super + ]                   |- Grow horizontally
  Super + Ctrl + [            |- Shrink horizontally (faster)
  Super + Ctrl + ]            |- Grow horizontally (faster)
  Super + Ctrl + -            |- Shrink vertically (faster)
  Super + Ctrl + =            |- Grow vertically (faster)

## Launchers ##################################################################

  Super + o                   |- Open application launcher
  Alt + tab                   |- Open window picker (WIP)
  Alt + tab                   |- Open window picker (WIP)

  Note: Each of the remaining launcher bindings should be prefixed by 
    Super + Space, e.g. Super + Space, THEN Super + r to open the "Restart"
    Menu.

  Super + r                   |- [R]estarter menu (for wm + daemons)
  Super + m                   |- [M]usic menu
  Super + v                   |- [V]olume menu
  Super + s                   |- [S]creenshot menu
  Super + l                   |- [L]inks menu
  Super + f                   |- [F]iles menu
  Super + t                   |- [T]MUX menu (deprecated, mostly)
  Super + y                   |- Scripts menu
  Super + /                   |- Help menu (needs a rework)

## Kitty ######################################################################

  Some helpful aliases:

  Ctrl + Shift                |- KMOD
  Ctrl + Shift + Space        |- SPACEK 

  Note: ';' denotes a chorded action, e.g. 'Reload kitty config' can be read as
  Ctrl + Shift + r (release r) Ctrl + Shift + Space

  KMOD + r; SPACEK            |- Reload Config
  KMOD + tab                  |- Next tab
  SPACEK; KMOD + p            |- Next tab
  SPACEK; KMOD + n            |- Previous tab
  SPACEK; KMOD + o            |- New tab
  KMOD + Return               |- New tab
  SPACEK; KMOD + Return       |- New window
  KMOD + hjkl                 |- Focus window in direction
  KMOD + g; KMOD + hjkl       |- Swap window in direction
  KMOD + r; KMOD + hl         |- Rotate windows in direction
  KMOD + ,                    |- Use last layout
  KMOD + .                    |- Use next layout
  KMOD + m                    |- Toggle layout 'stack' (monocle-like)
  KMOD + q                    |- Close Window

## ZSH #######################################################################

  Mostly vanilla, with a few exceptions. These will be noted.

  Use `bindkey -l` to see a list of keymap groups. Use `bindkey -M <group>` 
  (capitalization matters!) to see the actual bindings. Current bindings are 
  listed in `.config/zsh/keybindings`

  Ctrl + w                    |- Delete word backwards (vanilla)
  Ctrl + u                    |- Delete line 
  Ctrl + v                    |- Delete in quotes 
  Ctrl + l                    |- Clear screen (vanilla)
  Ctrl + d                    |- Show completions (vanilla)
  Ctrl + j                    |- Forward one word
  Ctrl + k                    |- Backward one word
  Ctrl + r                    |- zsh-navigation-tools-history-widget
  Esc                         |- Enter Vim mode (vim keybinds)
  Esc + Esc                   |- Re-Enter last or append to current 
                              |    command as root
  Alt + ui                    |- Go backwards/forwards in directory history
  Alt + jk                    |- Go down/up a directory 


## Utility Programs ###########################################################

  Alt + \                     |- Dunst: Close all notifications
  Alt + Shift + \             |- Dunst: Show nofitications history
  Alt + Backspace             |- Dunst: Close latest notification
  Alt + c                     |- Clipmenu: Show recent (rofi wrapper)
  Super + Ctrl + p            |- Flameshot: Desktop screenshot
  Super + Ctrl + shift + p    |- Flameshot: ALL desktops screenshot
  Super + Ctrl + s            |- Flameshot: GUI screenshot (snipping)

## MPD and Media ##############################################################

  Alt + Ctrl + j/k            |- Volume down/up
  Alt + Ctrl + h/l            |- Track prev/next (also restarts track)
  Alt + Ctrl + ,/.            |- Seek back/forwards
  Alt + Ctrl + Space          |- Pause MPD
  Alt + Ctrl + Return         |- Play MPD
  Alt + Ctrl + Backspace      |- Stop MPD
  Alt + Ctrl + m              |- Open Miniplayer (mpd gui)

EOF
