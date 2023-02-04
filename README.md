# Dotfiles

Don't expect a lot of stability here. I tinker with this constantly.

## Programs

- Window Manager:
  - Main: [bspwm](https://github.com/baskerville/bspwm) + [sxxhkd](https://github.com/baskerville/sxhkd)
  - Also [i3](https://i3wm.org/) with [i3blocks](https://github.com/vivien/i3blocks) as an i3status replacement
- Shell: ZSH (w/ [Oh-My-Zsh](https://ohmyz.sh/) and [Starship](https://starship.rs/))
- Text Editor: [NeoVim](https://neovim.io/) and [VSCodium](https://vscodium.com/)
- Widgets and Bars:
  - BSPWM:
    - [Rofi](https://github.com/davatorium/rofi)
    - [Eww](https://github.com/elkowar/eww)
    - [Polybar](https://github.com/polybar/polybar)
  - i3:
    - [i3blocks](https://github.com/vivien/i3blocks)
- Terminal Emulator: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Screenshots: [Flameshot](https://flameshot.org/) (wanna look into Scrot tho)
- Notifications: [Dunst](https://dunst-project.org/)
- Wallpapers:
  - [Pywal](https://github.com/dylanaraps/pywal) (autogenerate colorschemes)
  - No longer using: [Nitrogen](https://github.com/l3ib/nitrogen/)
    - For some reason, Nitrogen basically doubled my system resource usage ╮(╯_╰)╭
- Compositor: [Picom](https://github.com/yshui/picom)
- Clipboard: [Clipmenu](https://github.com/cdown/clipmenu)

## Keybinds

Run `keybinds.sh` to see keybindings.

### Notes

I use the KDE lock screen, so I can quickly swap between the desktops in
`/usr/share/xsessions`. Makes it easy to test and hop between different environments.

Some Alacritty stuff is sprinkled around these configs, but I've moved to Kitty
p much. I don't have any real Kitty configs yet, I've only been using it for a couple
of weeks.

Similarly for Tmux: Kitty does 90% of what I need so tmux files are kind of
redundant now.

Eww is probably the newest addition to this ecosystem, so it's the least fleshed
out.

My Polybar, Eww, and Rofi folders contain a lot of stuff from various other
repos (that I didn't author) so it can be pretty confusing to navigate. As far as
_which_ of those configs I use/wrote, check these files and folders:

- 'polybar/grayblocks'
- 'rofi/scripts/myscripts'
- ... and eww is just a mess rn

Widgets and Dunst are launched/killed with either a keybind or they're part of the `baspwmrc` file.

## Window Managers

**BSPWM + SXHKD**.

Includes a script for launching a scratchpad terminal.

I made it a personal rule to only use `Super` in global operations (crazy), so
every command in the `sxhkdrc` will begin with that key.

Rofi menus are accessed via a set of `Super + Space` then `Super + <X>` -type
commands.

---

**i3**

I caved and tried it out. I really like it, mostly because it handles a couple
things out of the box that bspwm does not. But I still prefer bspwm for the
flexibility and simplicity.

## The Big One

NeoVim config.

Nightmare mode.

There's some old, useless config definitions in the `lua/plugin` directory when
I was working on this idea of "custom, declarative instances" using vim globals
and command line arguments, but you can get 90% of what you need just from autocmds
and Snippets, so just ignore everything outside of the `dev` folder and
`packer.lua`.

Integration options w/ VSCodium's NeoVim extension exist, but I don't _really_
use VSCodium for anything now.

All plugin configurations are in `after/plugin`.

All keymaps are in `lua/keymaps`. `global-keymaps` don't have any dependencies
and are loaded automatically.

`plugin-keymaps` are essentially containers for
various plugin-related bindings. These get used in the plugin setup
functions in `after/plugin`.

---

Snippets are in `.lua` format in `snippets`.

Custom Telescope pickers are in `lua/ui/pickers`

I also wrote a little function that makes the dashboard grab a random piece of
ASCII art for the logo and display image (text is dynamic too!) on launch, so if
its fugly, that's why. It's random lol. Sometimes you get a masterpiece like the
Notepad logo + Garfield, so it's aesthetically consistent with the state of
these files.

---

Check out [neovim.md](./nvim.md) for more info on bindings and plugins.

## Other stuff I use

- MPD w/ NCMPCPP (pavucontrol to swap headsets)
- VLC _AND_ mpc (different use cases)
- Ranger
- Zathura
- Discord Canary
- Brave
- qutebrowser
