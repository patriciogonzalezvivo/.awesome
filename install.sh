#!/bin/bash

sudo apt-get install awesome wpagui compton rofi i3lock-fancy kbdd libxcb-cursor-dev

xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"

# make all submodules point to the master branch
git pull
git submodule init
git submodule update

# create symbolic links to the icons and themes
cd ~
ln -s ~/.awesome/icons .icons
ln -s ~/.awesome/themes .themes

# replace the default awesome configuration
if [ -d ~/.config/awesome ]; then
	rm -rf ~/.config/awesome
fi

cd ~/.config/
ln -s ~/.awesome/awesome awesome
ln -s ~/.awesome/compton.conf compton.conf

cd ~

# TODO:
# - install latest version of rofi https://github.com/davatorium/rofi/
# 		git clone --recursive --depth 1 https://github.com/DaveDavenport/rofi
#		cd rofi
#		autoreconf -i
#       mkdir build && cd build
#		../configure --prefix=/usr/
#		make
#		sudo make install
