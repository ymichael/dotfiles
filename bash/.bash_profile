export LC_CTYPE="en_US.UTF-8"

 #Git Stuff
source ~/bin/git-completion.bash
function parse_git_dirty {
	git diff --quiet || echo "*"
}
function parse_git_branch {
	git branch &> /dev/null || return 1
    echo " ($(git branch | awk '/^\*/ { print $2 }')$(parse_git_dirty))"
}

PS1='[\u:\[\e[31;1m\]\W\[\e[0m\]\[\e[32;1m\]$(parse_git_branch)\[\e[0m\]]\$ '

# Enable vim key bindings in bash
set -o vi

export TERM=screen-256color

function pygrep() {
    grep -nIr --include=*.py $@ \.
}

function jsgrep() {
    grep -nIr --exclude-dir=node_modules --include=*.js $@ \.
}

function cssgrep() {
    grep -nIr --include=*.css $@ \.
}

# Enable CLI Colors
export CLICOLOR="1"

# LS, CD
export LSCOLORS="Cxfxcxdxbxegedabagacad"
# l => long form
# a => all files (incl. hidden files)
# G => colors
# h => use units for filesizes
alias la='ls -ahG'
# cd and ls in one command
function cl() {
    cd "$@" && la;
}

alias gitroot='cd $(git rev-parse --show-cdup)'

function ta() {
    if tmux ls | grep "\b$@\b"
    then
        tmux attach -t $@
    else
        tmux new -s $@
    fi
}

# Aliases
alias py="python"
alias ipy="ipython"

alias proj="cl ~/Dropbox/Projects"
alias school="cl ~/Dropbox/School"

# grep with color
alias grep="grep --color=always"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias cprof='~/Dropbox/Projects/cprofilev/cprofilev.py'
alias pypy_pip='/usr/local/share/pypy/pip'
