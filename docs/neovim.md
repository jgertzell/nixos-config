# Neovim Usage Guide

This Neovim setup is intentionally smaller than LazyVim. It uses `lazy.nvim` for plugin management and adds a focused set of beginner-friendly tools.

## Leader Key

The leader key is `Space`.

When a shortcut starts with `<leader>`, press `Space` first. For example, `<leader>ff` means:

```text
Space, then f, then f
```

`which-key.nvim` shows available key hints after pressing `Space` and pausing briefly.

## File Explorer

The file explorer is provided by `neo-tree.nvim`.

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle file explorer |

Inside the file explorer, useful defaults include:

| Key | Action |
| --- | --- |
| `Enter` | Open file or directory |
| `a` | Add file or directory |
| `d` | Delete file or directory |
| `r` | Rename file or directory |
| `q` | Close explorer window |
| `?` | Show explorer help |

## Finding Files And Text

Fuzzy finding is provided by `telescope.nvim`. It uses `fd` and `ripgrep`, which are installed by the Home Manager config.

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files by name |
| `<leader>fg` | Search text in files |
| `<leader>fb` | Switch between open buffers |
| `<leader>fh` | Search Neovim help tags |

In Telescope:

| Key | Action |
| --- | --- |
| `Ctrl-n` | Move to next result |
| `Ctrl-p` | Move to previous result |
| `Enter` | Open selected result |
| `Esc` | Close Telescope |

## Basic Editing Shortcuts

| Key | Action |
| --- | --- |
| `<Esc>` | Clear search highlight |
| `<leader>w` | Save current file |
| `<leader>q` | Quit current window |
| `<leader>?` | Open this Neovim cheat sheet in a new tab |

## Terminal Cheat Sheet

The same guide can be viewed from the terminal with `glow`:

```sh
nvim-cheatsheet
```

There is also a shorter alias for the same command:

```sh
nvim-help
```

Line numbers, relative line numbers, mouse support, system clipboard integration, persistent undo, smart search case handling, and split previews for substitutions are enabled.

## Code Navigation And LSP

Language server support is provided by `nvim-lspconfig`. Language servers are installed declaratively through Nix rather than downloaded by Neovim.

These keybindings are available when a language server is attached to the current buffer:

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Show references |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |

Configured language tooling includes Lua, JSON, and YAML. C# and Razor are handled by `easy-dotnet.nvim`, which starts Roslyn automatically when opening C#, Razor, or CSHTML files.

## Diagnostics

Diagnostics are warnings, errors, and hints reported by language servers.

| Key | Action |
| --- | --- |
| `<leader>xx` | Toggle all diagnostics in Trouble |
| `<leader>xX` | Toggle diagnostics for the current buffer |

You will also see diagnostic signs in the sign column next to line numbers.

## Completion

Completion is provided by `blink.cmp`.

In insert mode, completion suggestions appear automatically when available. Documentation for the selected item is shown automatically.

Common completion keys:

| Key | Action |
| --- | --- |
| `Ctrl-n` | Next completion item |
| `Ctrl-p` | Previous completion item |
| `Enter` | Accept selected item |
| `Ctrl-e` | Hide completion menu |

## Comments And Pairs

`Comment.nvim` provides comment toggling using its default mappings:

| Key | Action |
| --- | --- |
| `gcc` | Toggle comment for current line |
| `gc` in visual mode | Toggle comment for selection |

`nvim-autopairs` automatically inserts matching brackets, quotes, and parentheses while typing.

## Git Indicators

`gitsigns.nvim` shows Git changes in the sign column:

| Sign | Meaning |
| --- | --- |
| `+` | Added line |
| `~` | Changed line |
| `_` | Deleted line nearby |

## Plugin Management

Plugins are managed by `lazy.nvim`.

Useful commands:

| Command | Action |
| --- | --- |
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install, update, and clean plugins |
| `:Lazy update` | Update plugins |
| `:Lazy check` | Check for plugin updates |

The plugin list is declared in `home/jgertzell/programs/neovim.nix`. After changing that file, apply the Home Manager/NixOS configuration again.
