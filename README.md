# How to use this

- `inputrc`
	- `ln -s /path/to/inputrc ~/.inputrc`
	- this configures case insenstive auto completion

- `vimrc`
	- install Vundle
		- https://github.com/VundleVim/Vundle.vim#quick-start
	- `ln -s /path/to/vimrc ~/.vimrc`
	- Open vim, run `:VundleInstall`

- `bash`
	- Add git completion script to ~/bin `ln -s /path/to/git-completion.bash ~/bin/`
	- Source bash_profile in existing bash_profile:
		- Add the following line to ~/.bash_profile `source "/path/to/bash/.bash_profile"
		- source `~/.bash_profile`