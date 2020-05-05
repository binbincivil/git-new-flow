#!/bin/bash

# git-nflow make-less installer for *nix systems

# Does this need to be smarter for each host OS?
if [ -z "$INSTALL_PREFIX" ] ; then
	INSTALL_PREFIX="/usr/local/bin"
fi

if [ -z "$REPO_NAME" ] ; then
	REPO_NAME="git-new-flow"
fi

if [ -z "$REPO_HOME" ] ; then
	REPO_HOME="https://github.com/binbincivil/git-new-flow.git"
fi

EXEC_FILES="git-nflow"
SCRIPT_FILES="git-nflow-init git-nflow-feature git-nflow-version git-nflow-common gitnflow-gitflow-common gitnflow-shFlags"
SUBMODULE_GITFLOW="gitnflow-gitflow-common"
SUBMODULE_SHFLAGS="gitnflow-shFlags"

echo "### gitnflow no-make installer ###"

case "$1" in
	uninstall)
		echo "Uninstalling git-nflow from $INSTALL_PREFIX"
		if [ -d "$INSTALL_PREFIX" ] ; then
			for script_file in $SCRIPT_FILES $EXEC_FILES ; do
				echo "rm -vf $INSTALL_PREFIX/$script_file"
				rm -vf "$INSTALL_PREFIX/$script_file"
			done
		else
			echo "The '$INSTALL_PREFIX' directory was not found."
			echo "Do you need to set INSTALL_PREFIX ?"
		fi
		exit
		;;
	help)
		echo "Usage: [environment] gitnflow-installer.sh [install|uninstall]"
		echo "Environment:"
		echo "   INSTALL_PREFIX=$INSTALL_PREFIX"
		echo "   REPO_HOME=$REPO_HOME"
		echo "   REPO_NAME=$REPO_NAME"
		exit
		;;
	*)
		echo "Installing git-nflow to $INSTALL_PREFIX"
		if [ -d "$REPO_NAME" -a -d "$REPO_NAME/.git" ] ; then
			echo "Using existing repo: $REPO_NAME"
			lastpwd=$PWD
			cd "$REPO_NAME"
			git checkout master && git pull origin master
			cd "$lastpwd"
		else
			echo "Cloning repo from GitHub to $REPO_NAME"
			git clone "$REPO_HOME" "$REPO_NAME"
		fi
		if [ -f "$REPO_NAME/$SUBMODULE_GITFLOW" -a -f "$REPO_NAME/$SUBMODULE_SHFLAGS" ] ; then
			echo "Submodules look up to date"
		else
			echo "Updating submodules"
			lastpwd=$PWD
			cd "$REPO_NAME"
			git submodule init
			git submodule update
			cd "$lastpwd"
		fi
		install -v -d -m 0755 "$INSTALL_PREFIX"
		for exec_file in $EXEC_FILES ; do
			 install -v -m 0755 "$REPO_NAME/$exec_file" "$INSTALL_PREFIX"
			echo "$REPO_NAME/$exec_file";
		done
		for script_file in $SCRIPT_FILES ; do
			 install -v -m 0644 "$REPO_NAME/$script_file" "$INSTALL_PREFIX"
			echo "$REPO_NAME/$script_file";
		done
		exit
		;;
esac
