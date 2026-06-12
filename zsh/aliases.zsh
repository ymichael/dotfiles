# zsh aliases & functions — ported from bash/.bash_profile.
# install.sh symlinks this into $ZSH_CUSTOM so oh-my-zsh loads it automatically.
#
# Bash-only bits (PS1 prompt, git-completion.bash) are intentionally omitted —
# oh-my-zsh's prompt theme and `git` plugin already cover those.

export LC_CTYPE="en_US.UTF-8"

# vi keybindings in the shell (bash: `set -o vi`)
bindkey -v

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

# Project shortcuts from the original dotfiles (Dropbox paths — uncomment and
# adjust if you keep those folders on this machine):
# alias proj="cl ~/Dropbox/Projects"
# alias school="cl ~/Dropbox/School"
