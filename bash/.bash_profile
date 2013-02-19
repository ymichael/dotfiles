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

# Git Stuff
source ~/bin/git-completion.bash
function parse_git_dirty {
	git diff --quiet || echo "*"
}
function parse_git_branch {
	git branch &> /dev/null || return 1
    echo " ($(git branch | awk '/^\*/ { print $2 }')$(parse_git_dirty))"
}

PS1='[\u:\[\e[31;1m\]\W\[\e[0m\]\[\e[32;1m\]$(parse_git_branch)\[\e[0m\]]\$ '

# hack.
source ~/.bashrc
