The basic configuration for a Linux AWS development environment. This is
composed of:

* init.sh	The automated installation script
* py.vimrc	A Python-specific .vimrc file
* std.vimrc	A standard .vimrc file
* .tmux.conf	A customized tmux configuration file

The workflow for these files is as follows:

1) Install git on the destination machine
2) Clone these files into the desired repository
3) Run init.sh
4) Curse myself because this is incomplete
5) Add a bit more functionality in some downtime
6) Commit
7) Customize the build environment as needed with the additional scripts
8) Repeat on new build

