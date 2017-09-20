#!/bin/bash

BITS=
PKG_MGR=''

function end_initialization {
	echo Development environment initialized.
	exit $1
}

function report_err {
	echo ERR: $2
	end_initialization $1
}

function set_bits {
	case $(uname -m) in
		x86_64)
			BITS=64
			;;
		i*86)
			BITS=32
			;;
		*)
			BITS=0
	esac
}

function set_package_manager {
	if [ -f /etc/redhat-release ]; then
		PKG_MGR='yum'
	elif [ -f /etc/SuSe-release ]; then
		PKG_MGR='yum'
	elif [ -d /etc/yum ]; then
		PKG_MGR='yum'
	elif [ -f /etc/debian_version ]; then
		PKG_MGR='apt-get'
	elif [ -f /etc-lsb-release ]; then
		PKG_MGR='apt-get'
	fi
}

echo Initializing development environment...
echo - Determining bit count...
set_bits

if [ $BITS -eq 0 ]; then
	report_err -2 'Bit count cannot be determined.'
else
	echo - $BITS-bit system detected.
fi

echo - Determining package manager...
set_package_manager

if [ "$PKG_MGR" == "" ]; then
	report_err -3 'Package manager cannot be determined.'
else
	echo - Package manager: $PKG_MGR
fi

# Install the base packages
sudo $PKG_MGR install tmux

# Install the Python packages
# TODO: This may need to be under sudo
sudo pip install flake8 autopep8 numpy

# Install Pathogen
if [ ! -d /home/ec2-user/.vim ]; then
	mkdir /home/ec2-user/.vim
fi

if [ ! -d /home/ec2-user/.vim/autoload ]; then
	mkdir /home/ec2-user/.vim/autoload
fi

if [ ! -d /home/ec2-user/.vim/bundle ]; then
	mkdir /home/ec2-user/.vim/bundle
fi

if [ ! -e /home/ec2-user/.vim/autoload/pathogen.vim ]; then
	curl -LSso /home/ec2-user/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# Install NERDTree
if [ ! -d /home/ec2-user/.vim/bundle/nerdtree ]; then
	git clone https://github.com/scrooloose/nerdtree.git /home/ec2-user/.vim/bundle/nerdtree
fi

# Install vim-flake8
if [ ! -d /home/ec2-user/.vim/bundle/flake8 ]; then
	git clone https://github.com/nvie/vim-flake8.git /home/ec2-user/.vim/budle/flake8
fi

# Install vim-autopep8
if [ ! -d /home/ec2-user/.vim/bundle/autopep8 ]; then
	git clone https://github.com/tell-k/vim-autopep8.git /home/ec2-user/vim/bundle/autopep8
fi

# Make the standard vimrc file the default
if [ ! -e /home/ec2-user/.vimrc ]; then
	cp ./std.vimrc /home/ec2-user/.vimrc
fi

end_initialization 0

