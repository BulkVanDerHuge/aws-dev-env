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

if [ $PKG_MGR == '' ]; then
	report_err -3 'Package manager cannot be determined.'
else
	echo - Package manager: $PKG_MGR
fi

# TODO: Install the following:
#	vim
#		pathogen
#			NERDTree
#		std.vimrc as .vimrc
#		~/py.vimrc as ~/.vimrc.py

end_initialization 0

