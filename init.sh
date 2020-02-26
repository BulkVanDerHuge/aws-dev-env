#!/bin/bash

BITS=
PKG_MGR=''

function end_initialization {
	echo Development environment initialized.
	exit $1
}

function install_vim_pkg {
    PKG_NM=$1
    GIT_LOC=$2

    if [ ! -d $VIM_BUNDLE/$PKG_NM ]; then
        git clone $GIT_LOC $VIM_BUNDLE/$PKG_NM
    fi
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
sudo $PKG_MGR install python3 tmux

VIM=
VIM_AUTO_LOAD=
VIM_BUNDLE=

# Install Pathogen
if [ ! -d $HOME/.vim ]; then
	mkdir $HOME/.vim
fi

VIM=$HOME/.vim
echo - Setting vim directory to $VIM

if [ ! -d $VIM/autoload ]; then
	mkdir $VIM/autoload
fi

VIM_AUTOLOAD=$VIM/autoload
echo - Setting vim autoload directory to $VIM_AUTOLOAD

if [ ! -d $VIM/bundle ]; then
	mkdir $VIM/bundle
fi

VIM_BUNDLE=$VIM/bundle
echo - Setting vim bundle directory to $VIM_BUNDLE

if [ ! -e $HOME/ec2-user/.vim/autoload/pathogen.vim ]; then
	curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# Install NERDTree
install_vim_pkg nerdtree https://github.com/scrooloose/nerdtree.git

# Install vim-flake8
install_vim_pkg flake8 https://github.com/nvie/vim-flake8.git

# Install vim-autopep8
install_vim_pkg autopep8 https://github.com/tell-k/vim-autopep8.git

# Install file-line
install_vim_pkg file-line https://github.com/bogado/file-line.git

# Install syntastic
install_vim_pkg syntastic https://github.com/vim-syntastic/syntastic.git

# Install tagbar
install_vim_pkg tagbar https://github.com/majutsushi/tagbar.git

# Install vim-airline
install_vim_pkg vim-airline https://github.com/vim-airline/vim-airline.git

# Make the Python vimrc file the default (blegh!)
if [ ! -e $HOME/.vimrc ]; then
	cp ./py.vimrc $HOME/.vimrc
fi

end_initialization 0

