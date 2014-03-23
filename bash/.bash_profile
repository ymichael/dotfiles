# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export EC2_HOME=~/.ec2
export EC2_PRIVATE_KEY=pk-UWZNAITNQRUVX7MLUTVM4BJKSJ5ZMFIG.pem
export EC2_CERT=cert-UWZNAITNQRUVX7MLUTVM4BJKSJ5ZMFIG.pem
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
export EC2_URL=https://ec2.ap-southeast-1.amazonaws.com

# PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$EC2_HOME/bin
PATH=$PATH:~/bin
PATH=$PATH:/usr/local/sbin:/usr/local/bin
export PATH

export LC_CTYPE="en_US.UTF-8"
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments

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

# added by Anaconda 1.8.0 installer
export PATH="/Users/michael/anaconda/bin:$PATH"

export TERM=screen-256color

function pygrep() {
    grep -nIr --include=*.py $@ \.
}

function jsgrep() {
    grep -nIr --include=*.js $@ \.
}

function css() {
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
alias mongodb="mongod run --config /usr/local/etc/mongod.conf"
alias redis="redis-server /usr/local/etc/redis.conf"
alias mysql="mysql.server start"
alias couch="~/Dropbox/Projects/couchdb-fauxton/utils/run"
alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc"
# use `serve` instead. (npm package, install globally)
# alias server="python -m SimpleHTTPServer"

# SSH aliases
alias ymichael="ssh ec2-user@yrmichael.com"

# lazy
alias todo="todo.sh"
alias py="python"
alias ipy="ipython"
alias spidermonkey="js -i"
alias hglog="hg log --template \"{rev}:{node|short} {parents}{desc|firstline}\n\""

alias proj="cl ~/Dropbox/Projects"
alias school="cl ~/Dropbox/School"

# python hyde
alias hyde="python ~/Dropbox/Projects/_lib/hyde/hyde.py"

# grep with color
alias grep="grep --color=always"
alias rmvimundo="find . | grep un~ --color=no | xargs rm"

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias cprof='~/Dropbox/Projects/cprofilev/cprofilev.py'
alias pypy_pip='/usr/local/share/pypy/pip'