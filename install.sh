#!/usr/bin/env bash
# Bootstrap these dotfiles on a fresh machine (macOS, zsh-first).
# Idempotent: safe to re-run. Run with:  ./install.sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }

# link <src-relative-to-dotfiles> <dest-abspath>
link() {
  local src="$DOTFILES/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    log "skip $dest (real file exists — back it up and re-run to replace)"
    return
  fi
  ln -sfn "$src" "$dest"
  log "linked $dest -> $src"
}

# 1. oh-my-zsh (modern macOS defaults to zsh)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log "installing oh-my-zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "oh-my-zsh already installed"
fi

# 2. shell-agnostic config symlinks
link inputrc          "$HOME/.inputrc"
link tmux.conf        "$HOME/.tmux.conf"
link gitignore_global "$HOME/.gitignore_global"
link vim/vimrc        "$HOME/.vimrc"
git config --global core.excludesfile "$HOME/.gitignore_global"
log "set git core.excludesfile -> ~/.gitignore_global"

# 3. zsh aliases/functions -> oh-my-zsh custom dir (auto-sourced)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
link zsh/aliases.zsh "$ZSH_CUSTOM/dotfiles.zsh"

# 4. vim: Vundle + plugins
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  log "installing Vundle"
  git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi
log "installing vim plugins (:PluginInstall)"
if vim +PluginInstall +qall </dev/tty >/dev/tty 2>&1; then
  :
else
  log "automated PluginInstall failed (no TTY?) — open vim and run :PluginInstall manually"
fi

log "Done. Open a new terminal, or run: source ~/.zshrc"
cat <<'NOTE'

Optional extras this script does NOT install:
  - ripgrep + fzf      (used by the vimrc):  brew install ripgrep fzf
                       (or download the prebuilt binaries into ~/.local/bin)
  - a Powerline/Nerd font for vim-airline glyphs, then select it in your terminal
  - coc language servers, from inside vim:  :CocInstall coc-tsserver coc-json
NOTE
