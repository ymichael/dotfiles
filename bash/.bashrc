# Seperate aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
