# Roxgen - Fast, Extensible Color Palette Generator

This is forked from [hellwal](https://github.com/danihek/hellwal) as the developer
appears to no longer care about the project and is unlikely to merge any bug fixes into
his tree.

## Building

Clone git repo, run make command and you are ready to go! - you just need a C compiler and gnumake!

```sh
git clone https://github.com/keircn/roxgen && cd roxgen && make
```

## How to use?

Run this with your wallpaper image:

```sh
roxgen -i [image]
```

You can also randomly pick an image from a given directory like this:

```sh
roxgen -i <folder> --random
```

Generated templates are saved in `~/.cache/roxgen/`.

## Templates

There are also examples in the [templates folder](./templates). They look more-less like this:

```sh
# Main
background='%%background%%'
foreground='%%foreground%%'

# Path
wallpaper_path='%%wallpaper%%'

# Colors
color0='%%color0.hex%%'
color1='%%color1.hex%%'

# ... and so on and so forth.

color15='%%color15.hex%%'


# RGB
backgroundRGB='%%background.rgb%%'
foregroundRGB='%%foreground.rgb%%'

color15butRGB='%%color15.rgb%%'

```

You can get any generated color for values 0 to 15.

After the color keyword, you can specify the format: hex, rgb, or a single rgb channel.
By default, the template output is in hex.

### Available color template formats:

| Type | Input      | Output  |
| ---- | ---------- | ------- |
| hex  | color0.hex | 000000  |
| rgb  | color0.rgb | 0, 0, 0 |
| r    | color0.r   | 0       |
| g    | color0.g   | 0       |
| b    | color0.b   | 0       |

### Additional variables accepted by templates

Alongside colors, you can specify some variables to make them more suitable for your needs.
For now these variables are available:

| Variable | Description            | Usage                        |
| -------- | ---------------------- | ---------------------------- |
| alpha    | Set transparency value | `%% color1.hex alpha=0.5 %%` |

`alpha` is ignored for single rgb channels.

## JSON

You can use the `--json` argument to suppress any other output and write colors to `stdout` in JSON format.
You can then manipulate the output with `jq`. For example:

```sh
roxgen -i [wallpaper] --json | jq '.'
```

## Themes

You can set your own theme, re-run it anytime and apply it to your config or other programs!
It can be a previously generated palette from an image,
[gruvbox](https://github.com/morhetz/gruvbox),
[Tokyo Night](https://github.com/tokyo-night/tokyo-night-vscode-theme),
or anything you want! For example, gruvbox theme:

```sh
%% color0  = #282828 %%
%% color1  = #cc241d %%
%% color2  = #98971a %%
%% color3  = #d79921 %%
%% color4  = #458588 %%
%% color5  = #b16286 %%
%% color6  = #689d6a %%
%% color7  = #a89984 %%
%% color8  = #928374 %%
%% color9  = #fb4934 %%
%% color10 = #b8bb26 %%
%% color11 = #fabd2f %%
%% color12 = #83a598 %%
%% color13 = #d3869b %%
%% color14 = #8ec07c %%
%% color15 = #ebdbb2 %%
```

Save the text above as a file or copy [gruvbox](./themes/gruvbox.roxgen) from this repo and
just run roxgen:

```sh
roxgen --theme ./themes/gruvbox.roxgen
```

I recommend putting all themes in the default theme folder `~/.config/roxgen/themes`.
This way, you can provide the theme name without specifying the path, and roxgen will pick it
up automatically. Of course if you want, you can also set a different theme folder.
For example:

```sh
roxgen -t gruvbox.roxgen --theme-folder ~/dotfiles/configs/roxgen/themes
```

## NEON Mode

Neon mode boosts colors to make them look more vibrant and bold. Sometimes it's a pain in the EYE,
but it often looks better. Turned **off** by default.

```sh
roxgen -i [wallpaper] --neon-mode
```

## Modes

You can select `-d`/`--dark` or `-l`/`--light` mode on any given image, theme, etc., no
matter if it's generated from an image or from a theme file. There is also `--color` mode.

### Dark mode (on by default)

```sh
roxgen -i [wallpaper] --dark
```

### Light mode

```sh
roxgen -i [wallpaper] --light
```

### color mode (crazyy one)

```sh
roxgen -i [wallpaper] --color
```

The best thing about it is that you are able to combine all of these together. Usually it's
not a good idea, but sometimes you can achieve some crazy color combinations!

```sh
roxgen -i [wallpaper] --color --light --dark
```

---

Also, you have a couple of cool arguments to manipulate how colors will be computed:

- you can darken all colors by specifying `--dark-offset` from 0-1 (the higher the value, the darker the colors):

```sh
roxgen -i [wallpaper] --light --dark-offset 0.5
```

- same with `--bright-offset` (the higher the value, the brighter the colors):

```sh
roxgen -i [wallpaper] --bright-offset 0.5
```

- invert colors with `--invert`:

```sh
roxgen -i [wallpaper] --light --invert
```

- specify grayscale, if you want monochromatic colors, with `--gray-scale`:

```sh
roxgen -i [wallpaper] --color --gray-scale 0.8
```

- ensure colors are readable against the background with `--check-contrast`:

```sh
roxgen -i [wallpaper] --check-contrast
```

## Scripts

With `--script` or `-s` you can run a script (or any shell command) after roxgen.

**Note**: it will only run if roxgen does not encounter any errors.

### On a side note:

If you want your new terminals to open with a previously generated or specified color palette,
add these templates to your `~/.config/roxgen/templates/` folder:

- [variables.sh](./templates/variables.sh)
- [terminal.sh](./templates/terminal.sh)

Run roxgen with an image or theme to generate the output scripts from the templates.

Then in `.bashrc`, add following lines:

```sh
source ~/.cache/roxgen/variables.sh
sh ~/.cache/roxgen/terminal.sh
```

### Alternatively if you use fish:

- [variablesfish.fish](./templates/variablesfish.fish)
- [terminal.sh](./templates/terminal.sh)

Then add this to your fish config:

```sh
source ~/.cache/roxgen/variablesfish.fish
sh ~/.cache/roxgen/terminal.sh
```

# Showcase

![More showcases of roxgen's generated palettes with various wallpapers](https://github.com/user-attachments/assets/ddf2a55e-0fbb-4661-827a-6b124f1dacdb)

# Special thanks:

- [dylanaraps](https://github.com/dylanaraps) - for [pywal](https://github.com/dylanaraps/pywal) and other amazing stuff he created.
