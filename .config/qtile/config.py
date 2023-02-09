# Copyright (c) 2023, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# ~/.config/qtile/config - qtile window manager config file

import subprocess
from libqtile import bar, hook, layout, widget
from libqtile.lazy import lazy
from libqtile.config import Group, Key, Match, Screen, Rule

# -- Key bindings-------------------------------------------------------------

# modifiers
mod = ['mod4']
modshift = mod + ['shift']
modcontrol = mod + ['control']

# set key bindings
keys = [

    # move focus between windows
    Key(mod, 'h', lazy.layout.left(),  desc='Move focus to left'),
    Key(mod, 'l', lazy.layout.right(), desc='Move focus to right'),
    Key(mod, 'j', lazy.layout.down(),  desc='Move focus down'),
    Key(mod, 'k', lazy.layout.up(),    desc='Move focus up'),
    Key(mod, 'space', lazy.layout.next(), desc='Move focus to next window'),

    # swap window positions
    Key(modshift, 'h', lazy.layout.shuffle_left(),  desc='Move window left'),
    Key(modshift, 'l', lazy.layout.shuffle_right(), desc='Move window right'),
    Key(modshift, 'j', lazy.layout.shuffle_down(),  desc='Move window down'),
    Key(modshift, 'k', lazy.layout.shuffle_up(),    desc='Move window up'),

    # resize monad windows (commands vary by layout)
    Key(modcontrol, 'h', lazy.layout.shrink_main(), desc='Shrink main window'),
    Key(modcontrol, 'l', lazy.layout.grow_main(),   desc='Grow main window'),
    Key(mod, 'n', lazy.layout.set_ratio(0.5), desc='Reset all window sizes'),

    # toggle between layouts
    Key(mod, 'Tab', lazy.next_layout(), desc='Toggle between layouts'),
    Key(mod, 'w', lazy.window.kill(), desc='Kill focused window'),

    # applications
    # FIXME configure rofi
    Key(mod, 'Return', lazy.spawn('terminal'), desc='Launch terminal'),
    Key(mod, 'b', lazy.spawn('firefox'), desc='Launch web browser'),
    Key(mod, 'f', lazy.spawn('thunar'), desc='Launch file browser'),
    Key(mod, 'm', lazy.spawn('thunderbird'), desc='Launch browser'),
    Key(mod, 'r', lazy.spawncmd(), desc='Run command in prompt widget'),
    Key(modshift, 'Return', lazy.spawn(
        'rofi -show drun -theme gruvbox-dark-soft'), desc='Run launcher'),

    # restart and quit qtile
    Key(modcontrol, 'r', lazy.reload_config(), desc='Reload the config'),
    Key(modcontrol, 'q', lazy.shutdown(), desc='Shutdown Qtile')]

# -- Groups (workspaces) -----------------------------------------------------

# define workspaces (or use icons ___)
# FIXME add custom layouts
names = ['Web', 'Code', 'Term', 'Docs', 'Mail', 'Chat', 'Music', 'Photo']
groups = [Group(name, dict(layout='max')) for name in names]

# assign keybindings
for i, name in enumerate(names, 1):
    keys.append(Key(
        mod, str(i), lazy.group[name].toscreen(),
        desc=f'Switch to group {name}'))
    keys.append(Key(
        modshift, str(i), lazy.window.togroup(name, switch_group=True),
        desc='Move window to group {name}'))

# -- Layouts -----------------------------------------------------------------

# gruvbox-dark 16 colors (https://github.com/morhetz/gruvbox)
colors = [
    '#282828', '#cc241d', '#98971a', '#d79921',  # bg red green yellow
    '#458588', '#b16286', '#689d6a', '#a89984',  # blue purple aqua gray
    '#928374', '#fb4934', '#b8bb26', '#fabd2f',  # gray red green yellow
    '#83a598', '#d3869b', '#8ec07c', '#ebdbb2']  # blue purple aqua fg

# layouts (first is the default)
layouts = [
    layout.MonadTall(
        border_width=1, margin=8, border_focus=colors[2],
        border_normal=colors[0]),
    layout.Max(),
    layout.RatioTile(),
]

# -- Screens and widgets -----------------------------------------------------

# more widgets to consider
# * system: Backlight, Battery, Bluetooth, DF, Wlan
# * sound: Cmus, Moc, PulseVolume, Volume
# * web: Canto (RSS), ImapWidget, KhalCalendar, Maildir, Notify
# * other: CheckUpdates, Chord, Cilpboard, Countdown, KeyboardLayout, Pomodoro

# widgets default style
widget_defaults = dict(
    font='Fira Code', fontsize=12, foreground=colors[15])

# widgets on left screen
widgets_left = [
    widget.GroupBox(
        active=colors[15],
        font='Fira Code Bold',
        foreground=colors[2],
        highlight_method='line',
        inactive=colors[8],
        other_current_screen_border=colors[12],
        other_screen_border=colors[4],
        rounded=False,
        this_current_screen_border=colors[10],
        this_screen_border=colors[2],
        highlight_color=colors[0],
    ),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.CurrentLayoutIcon(padding=0, scale=0.75),
    widget.CurrentLayout(),
    widget.Prompt(prompt=':'),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.WindowName(),
]

# widgets on right screen
widgets_right = [
    widget.CurrentLayoutIcon(padding=0, scale=0.75),
    widget.CurrentLayout(),
    widget.Prompt(prompt=':'),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.WindowName(),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.Net(format='{down} ↓↑{up}', prefix='k'),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.CPU(format='{freq_current}GHz {load_percent}%'),
    widget.ThermalSensor(),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.Memory(
        format='{MemUsed:.0f}/{MemTotal:.0f}{mm}', measure_mem='G'),
    widget.TextBox(text='|', foreground=colors[8]),
    widget.Clock(format='%a %d %b %H:%M'),  # or '%c' to include seconds
    widget.TextBox(text='|', foreground=colors[8]),
    widget.Systray()]

# screens
screens = [
    Screen(
        bottom=bar.Bar(widgets_left, size=24, background=colors[0]),
        wallpaper='~/.local/share/backgrounds/background0.jpg'),
    Screen(
        bottom=bar.Bar(widgets_right, size=24, background=colors[0]),
        wallpaper='~/.local/share/backgrounds/background1.jpg')]

# -- Configuration variables -------------------------------------------------

# open applications to specific workspaces
dgroups_app_rules = [
    Rule(Match(wm_class=['Navigator']), group='Web'),
    Rule(Match(wm_class=['Mail']), group='Mail'),
    Rule(Match(wm_class=['Slack']), group='Chat')]

# open applications in floating windows (use xprop to find wm class and name)
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='ncview')])


# -- Startup applications ----------------------------------------------------

# (use subscribe.startup to also exec on reloads)
@hook.subscribe.startup_once
def autostart():
    """Autostart background applications."""
    for cmd in [
            # '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1',
            # 'blueman-applet',         # not installed on polaris
            # 'xfce4-power-manager',    # not relevant on polaris
            'xautolock -time 10 -locker blurlock',  # session lock
            'picom -b',     # transparency and fade effects
            'clipit',       # tray clipboard manager
            'nm-applet',    # tray network manager
            'pamac-tray',   # tray update notifier
            'volumeicon']:  # tray volume icon
        subprocess.Popen(cmd.split(' '))
