# dotfiles

Personal dotfiles for a fresh **macOS** machine. Modern macOS ships **zsh** as
the default shell, so these are zsh-first (with [oh-my-zsh]) — the legacy bash
config is still here under `bash/` but is no longer the primary path.

## Quick start

```sh
git clone https://github.com/ymichael/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./install.sh
```

`install.sh` is idempotent — safe to re-run. It:

1. Installs [oh-my-zsh] if missing (keeps any existing `~/.zshrc`).
2. Symlinks the shell-agnostic config:
   - `inputrc`          → `~/.inputrc`   (case-insensitive completion)
   - `tmux.conf`        → `~/.tmux.conf`
   - `gitignore_global` → `~/.gitignore_global` (and sets `git core.excludesfile`)
   - `vim/vimrc`        → `~/.vimrc`
3. Symlinks `zsh/aliases.zsh` → `$ZSH_CUSTOM/dotfiles.zsh` so oh-my-zsh
   auto-loads the aliases/functions.
4. Installs [Vundle] and runs `:PluginInstall` for the vim plugins.

It will **not** overwrite a real (non-symlink) file already at a destination —
back it up and re-run to replace it.

## Optional extras (not automated)

- **ripgrep + fzf** (used by the vimrc): `brew install ripgrep fzf`
  (or drop the prebuilt binaries into `~/.local/bin`).
- A **Powerline/Nerd font** for the `vim-airline` glyphs (`g:airline_powerline_fonts`).
  Install one, then select it in your terminal profile (iTerm2: Settings →
  Profiles → Text → Font). Good options:
  - [Monaco Nerd Font](https://github.com/thep0y/monaco-nerd-font/releases) —
    patched Monaco; selects as "Monaco Nerd Font".
  - [MesloLGS NF](https://github.com/romkatv/powerlevel10k-media) — a solid
    default if you don't care about Monaco specifically.
- **coc language servers**, from inside vim: `:CocInstall coc-tsserver coc-json`.

> **Note on the colorscheme:** the vimrc sets `g:solarized_termcolors=256` so
> solarized renders correctly even when the terminal's ANSI palette isn't itself
> Solarized (e.g. default iTerm2). Without it the colors look wrong.

## What's in here

| Path                | Purpose                                                    |
| ------------------- | ---------------------------------------------------------- |
| `install.sh`        | One-command bootstrap (zsh-first).                         |
| `zsh/aliases.zsh`   | Aliases & functions (ported from `bash/.bash_profile`).    |
| `vim/vimrc`         | Vim config (Vundle-managed plugins).                       |
| `inputrc`           | Readline: case-insensitive completion.                     |
| `tmux.conf`         | tmux: vi mode keys, vim-style pane navigation.             |
| `gitignore_global`  | Global gitignore.                                          |
| `bash/`             | Legacy bash profile (pre-zsh). Source it manually if used. |
| `bin/`              | `git-completion.bash` (bash only).                         |

## Legacy bash setup

zsh is the default on modern macOS, but if you're on bash:

```sh
ln -s "$PWD/bin/git-completion.bash" ~/bin/
echo 'source "'"$PWD"'/bash/.bash_profile"' >> ~/.bash_profile
source ~/.bash_profile
```

[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh
[Vundle]: https://github.com/VundleVim/Vundle.vim#quick-start
