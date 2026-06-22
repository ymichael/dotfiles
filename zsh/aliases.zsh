# zsh aliases & functions — ported from bash/.bash_profile.
# install.sh symlinks this into $ZSH_CUSTOM so oh-my-zsh loads it automatically.
#
# Bash-only bits (PS1 prompt, git-completion.bash) are intentionally omitted —
# oh-my-zsh's prompt theme and `git` plugin already cover those.

export LC_CTYPE="en_US.UTF-8"

# vi keybindings in the shell (bash: `set -o vi`)
bindkey -v

# vi mode leaves Ctrl+R/Ctrl+S unbound (zsh only auto-binds them in emacs mode),
# so restore incremental history search in both vi insert and command keymaps.
# unsetopt flow_control frees Ctrl+S from terminal XON/XOFF so forward search works.
unsetopt flow_control
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M vicmd '^S' history-incremental-search-forward

# Colors for ls / CLI
export CLICOLOR="1"
export LSCOLORS="Cxfxcxdxbxegedabagacad"

# --- aliases ---
alias la='ls -ahG'
alias py="python"
alias ipy="ipython"
# grep with color (note: --color=always also colors piped output; switch to
# =auto if that ever interferes with parsing grep's output downstream)
alias grep="grep --color=always"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gitroot='cd $(git rev-parse --show-cdup)'

# --- functions ---
# cd and ls in one go
cl() { cd "$@" && la; }

# grep helpers scoped by file type
pygrep()  { grep -nIr --include=*.py  "$@" .; }
jsgrep()  { grep -nIr --exclude-dir=node_modules --include=*.js "$@" .; }
cssgrep() { grep -nIr --include=*.css "$@" .; }

# tmux attach-or-create
ta() {
    if tmux ls 2>/dev/null | grep -q "\b$1\b"; then
        tmux attach -t "$1"
    else
        tmux new -s "$1"
    fi
}

# Connect to the mbp-intel server and attach-or-create a tmux session using
# iTerm2's native control mode (-CC): remote tmux windows become real iTerm2
# tabs/windows, and the session persists on the server across disconnects.
# Run from inside iTerm2.  Usage: `mbp` (session "main") or `mbp work`.
# Full path to tmux: ssh runs a non-login shell whose PATH lacks /usr/local/bin
# (Homebrew), so a bare `tmux` wouldn't resolve. Panes inside tmux are login
# shells and get the normal PATH.
mbp() { ssh -t mbp-intel "/usr/local/bin/tmux -CC new -A -s ${1:-main}"; }

# Project shortcuts from the original dotfiles (Dropbox paths — uncomment and
# adjust if you keep those folders on this machine):
# alias proj="cl ~/Dropbox/Projects"
# alias school="cl ~/Dropbox/School"

# --- SSH-aware prompt marker ---------------------------------------------
# Over SSH, prepend a bold purple [hostname] tag to the prompt so a remote
# shell is visually distinct from a local one. %m = the remote's own short
# hostname, so this is generic across every machine you ssh into.
#
# A one-shot precmd hook is used (not a plain `PROMPT=...`) because oh-my-zsh
# sources this custom file BEFORE loading the theme, so setting PROMPT here
# directly would just be overwritten by the theme.
if [[ -n "$SSH_CONNECTION" || -n "$SSH_TTY" || -n "$SSH_CLIENT" ]]; then
  autoload -Uz add-zsh-hook
  _dotfiles_ssh_prompt() {
    PROMPT="%B%F{141}[%m]%f%b ${PROMPT}"
    add-zsh-hook -d precmd _dotfiles_ssh_prompt   # run once, then unhook
  }
  add-zsh-hook precmd _dotfiles_ssh_prompt
fi
