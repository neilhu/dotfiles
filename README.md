# dotfiles

Shell configuration for Linux / Bash.

## Installation

**Warning:** Review the files before running. These will overwrite files in your home directory. Existing files are backed up automatically before any changes are made, but you should still know what you're installing.

### Clone and bootstrap

```bash
git clone https://github.com/neilhu/dotfiles.git ~/sources/dotfiles
cd ~/sources/dotfiles
source bootstrap.sh
```

The bootstrap script copies all dotfiles to `$HOME`. Before overwriting anything, it backs up every file that would be changed to `~/.dotfiles_backup/<timestamp>/`.

To update later, `cd` into the repo and run:

```bash
source bootstrap.sh
```

To skip the confirmation prompt:

```bash
source bootstrap.sh --force
```

### Install required packages

After bootstrap, install the tools the dotfiles depend on:

```bash
bash packages.sh
```

### What gets installed

`bootstrap.sh` uses `rsync` to copy the following into `$HOME`:

| File / Directory | Purpose |
|---|---|
| `.bash_profile` | Login shell entry point; sources all other files |
| `.bashrc` | Sources `.bash_profile` for interactive shells |
| `.profile` | Sources `.bash_profile` for display manager login sessions |
| `.bash_prompt` | Solarized-themed prompt with Git status |
| `.aliases` | Shorthand commands |
| `.functions` | Shell functions (`mkd`, `extract`, `server`, `gz`, etc.) |
| `.exports` | Environment variables |
| `.inputrc` | Readline configuration |
| `.gitconfig` | Git defaults |
| `.gitignore` | Global gitignore |
| `.vimrc` / `.gvimrc` | Vim configuration |
| `.vim/` | Vim colors, syntax files, swap/backup/undo dirs |
| `.tmux.conf` | tmux configuration |
| `.screenrc` | GNU Screen configuration |
| `.curlrc` | curl defaults |
| `.wgetrc` | wget defaults |
| `.editorconfig` | Cross-editor indentation settings |
| `.hgignore` | Global Mercurial ignore |
| `.gdbinit` | GDB defaults |
| `.hushlogin` | Suppresses login banner |

### Customization without forking

Two files are sourced at login if they exist but are never committed:

- **`~/.path`** — extend `$PATH` before anything else runs.
- **`~/.extra`** — override aliases, functions, or exports; add machine-specific settings.

Example `~/.extra` for Git identity and GPG signing:

```bash
GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="you@example.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Enable GPG commit signing once a key is configured
git config --global commit.gpgsign true
```

## Notable aliases and functions

| Name | What it does |
|---|---|
| `extract <file>` | Extract any archive (`.tar.gz`, `.zip`, `.bz2`, `.7z`, `.rar`, …) |
| `server [port]` | Serves the current directory over HTTP (`python3 -m http.server`) |
| `mkd <dir>` | `mkdir -p` and `cd` in one step |
| `fs [path]` | Human-readable size of a file or directory |
| `gz <file>` | Shows original vs gzipped size and ratio |
| `targz <path>` | Creates a `.tar.gz` using zopfli/pigz/gzip depending on availability |
| `digga <domain>` | Runs `dig` and shows all records |
| `getcertnames <domain>` | Lists CNs and SANs from a site's TLS certificate |
| `tre` | `tree` with hidden files, color, and paged output |
| `o [path]` | Opens a file or directory (`xdg-open`; `explorer.exe` under WSL) |
| `diff` | Git's colored word-diff when git is available |
| `df` | Disk usage (human-readable) |
| `du` | Directory size (human-readable) |
| `free` | Memory usage (human-readable) |
| `localip` | Current machine's LAN IP |
| `urlencode <str>` | URL-encodes a string |
| `c` | Pipes stdin to the clipboard (`wl-copy` on Wayland, `xclip` on X11) |
| `map` | Alias for `xargs -n1` |
| `g` | Alias for `git` with full tab completion |

## tmux

Prefix is `Ctrl+A`.

| Binding | Action |
|---|---|
| `prefix \|` | Split pane horizontally |
| `prefix -` | Split pane vertically |
| `prefix h/j/k/l` | Navigate panes (vim-style) |
| `prefix r` | Reload config |

## Requirements

Run `packages.sh` to install everything at once, or install manually:

- Bash 4+
- Python 3 (for `server` and `urlencode`)
- `xclip` (X11) or `wl-clipboard` (Wayland) — for the `c` clipboard alias
- `xdg-utils` (for `o` / `xdg-open`)
- `dnsutils` (for `digga` and the public `ip` alias)
- `tree` (for `tre`)
- `bc` (for `gz`)
- `fzf` (optional — enables fuzzy `Ctrl+R`, `Ctrl+T`, `Alt+C` in bash)
