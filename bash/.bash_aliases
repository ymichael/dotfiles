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
