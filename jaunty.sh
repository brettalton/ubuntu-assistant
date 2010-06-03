#!/bin/bash

# Ubuntu Assistant - 9.04 (Jaunty Jackalope)
# Install requested and required programs and libraries for a better
#     desktop experience
# Copyright (C) 2007-2010  Brett Alton <brett.jr.alton@gmail.com>
# Last edited 2010-06-03

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Depends on Zenity
if [ ! -f /usr/bin/zenity ]; then
	gksu aptitude install zenity
fi


# Banshee / https://launchpad.net/~banshee-team/+archive/ppa
echo 'deb http://ppa.launchpad.net/banshee-team/ppa/ubuntu jaunty main' | gksu tee -a /etc/apt/sources.list.d/launchpad.list
gksu apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 9D2C2E0A3C88DD807EC787D74874D3686E80C6B7

# GNOME-Colors / https://launchpad.net/~gnome-colors-packagers/+archive/ppa
echo 'deb http://ppa.launchpad.net/gnome-colors-packagers/ppa/ubuntu jaunty main' | gksu tee -a /etc/apt/sources.list.d/launchpad.list
gksu apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 41c2359b9c2f88f0d47040322d79f61be8d31a30

# Medibuntu / https://help.ubuntu.com/community/Medibuntu
gksu wget http://www.medibuntu.org/sources.list.d/jaunty.list -O /etc/apt/sources.list.d/medibuntu.list

# Pidgin / https://launchpad.net/~pidgin-developers/+archive/ppa
echo 'deb http://ppa.launchpad.net/pidgin-developers/ppa/ubuntu jaunty main' | gksu tee -a /etc/apt/sources.list.d/launchpad.list
gksu apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 67265eb522bdd6b1c69e66ed7fb8bee0a1f196a8

# Themes / https://launchpad.net/~bisigi/+archive/ppa
echo 'deb http://ppa.launchpad.net/bisigi/ppa/ubuntu jaunty main' | gksu tee -a /etc/apt/sources.list.d/launchpad.list
gksu apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1781bd45c4c3275a34bb6aec6e871c4a881574de

# Wine / https://launchpad.net/~ubuntu-wine/+archive/ppa
echo 'deb http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu jaunty main' | gksu tee -a /etc/apt/sources.list.d/launchpad.list
gksu apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 883e8688397576b6c509df495a9a06aef9cb8db0

# GetDeb / PlayDeb
PLAYDEB=playdeb_0.3-1~getdeb1_all.deb
GETDEB=getdeb-repository_0.1-1~getdeb1_all.deb

if [ ! -f $PLAYDEB ]; then
	wget http://archive.getdeb.net/install_deb/$PLAYDEB
fi

if [ ! -f $GETDEB ]; then
	wget http://archive.getdeb.net/install_deb/$GETDEB
fi

gksu dpkg -i $PLAYDEB $GETDEB

if [ $? -eq 0 ]; then
	rm $PLAYDEB $GETDEB
else
	echo ' !! could not install playdeb/getdeb repositories!'
fi

# update
gksu aptitude update &&

# upgrade
gksu aptitude upgrade &&

# install
gksu aptitude install \
agave \
audacity \
banshee \
cheese \
community-themes \
cups-pdf \
elementary-icon-theme \
elementary-theme \
elementary-wallpapers \
faad \
ffmpeg \
flashplugin-nonfree \
flegita \
gnome-backgrounds \
gstreamer0.10-ffmpeg \
gstreamer0.10-plugins-bad \
gstreamer0.10-plugins-bad-multiverse \
gstreamer0.10-plugins-ugly \
gstreamer0.10-plugins-ugly-multiverse \
gstreamer0.10-pitfdll \
libdvdcss2 \
libdvdnav4 \
medibuntu-keyring \
mozilla-plugin-vlc \
msn-pecan \
murrine-themes \
ntfsprogs \
ntp \
nautilus-wallpaper \
non-free-codecs \
p7zip-full \
parcellite \
pidgin-facebookchat \
pidgin-guifications \
pidgin-libnotify \
pidgin-themes \
unrar \
vlc \
wine \
gnome-colors \
arc-colors \
shiki-colors &&

# add new Ubuntu logo in gnome-panel
cd $HOME
if [ ! -f $HOME/start-here.png ]; then
	wget http://staging.altonlabs.com/ubuntu_assistant/start-here.png
	
	# make sure the file downloaded properly
	if [ $? -ne 0 ]; then
		echo ' !! Could not download start-here.png!'
	else
		# delete old start-here.png, if it exists
		if [ -f $HOME/.icons/elementary-monochrome/apps/24/start-here.png ]; then
			rm -f $HOME/.icons/elementary-monochrome/apps/24/start-here.png
		fi
		
		# create directory if it doesn't exist
		if [ ! -d $HOME/.icons/elementary-monochrome/apps/24/ ]; then
			mkdir -p $HOME/.icons/elementary-monochrome/apps/24/
		fi

		cp -p $HOME/start-here.png $HOME/.icons/elementary-monochrome/apps/24/start-here.png
		rm $HOME/start-here.png
	fi
fi


# install jump-to-playing 0.3.1
cd $HOME
#wget http://www.stevenbrown.ca/blog/files/2008/10/jump-to-playing-0.3.1.tar.gz
wget http://staging.altonlabs.com/ubuntu_assistant/jump-to-playing-0.3.1.tar.gz

# make sure the file downloaded properly
if [ $? -ne 0 ]; then
	echo ' !! Could not download jump-to-playing plugin!'
fi

# delete old jump-to-playing plugin, if it exists
if [ -d $HOME/.gnome2/rhythmbox/plugins/jump-to-playing/ ]; then
	rm -r $HOME/.gnome2/rhythmbox/plugins/jump-to-playing/
fi

# create rhytmbox directory if it does not exist
if [ ! -d $HOME/.gnome2/rhythmbox/plugins/ ]; then
	mkdir -p $HOME/.gnome2/rhythmbox/plugins/
fi

# extract downloaded file to rhythmbox plugins directory
if [ -f $HOME/jump-to-playing-0.3.1.tar.gz ]; then
	tar -xvzf jump-to-playing-0.3.1.tar.gz -C $HOME/.gnome2/rhythmbox/plugins/ &&
	rm $HOME/jump-to-playing-0.3.1.tar.gz
else
	echo ' !! jump-to-playing-0.3.1.tar.gz not found -- could not install!'
fi


# fonts
cd $HOME
wget http://staging.altonlabs.com/ubuntu_assistant/fonts-20100415.tar.gz

# make sure the file downloaded properly
if [ $? -ne 0 ]; then
	echo ' !! Could not download fonts folder!'
fi

# create rhytmbox directory if it does not exist
if [ ! -d $HOME/.fonts/ ]; then
	mkdir -p $HOME/.fonts/
fi

# extract downloaded file to rhythmbox plugins directory
if [ -f $HOME/fonts-20100415.tar.gz ]; then
	tar -xvzf fonts-20100415.tar.gz -C $HOME/.fonts/ &&
	rm $HOME/fonts-20100415.tar.gz
else
	echo ' !! fonts-20100415.tar.gz not found -- could not install!'
fi

# /apps/gnome-screenshot
gconftool-2 --type bool --set  /apps/gnome-screenshot/include_pointer "false" # turn off mouse pointer in screenshots
# /apps/rhythmbox
gconftool-2 --type bool --set /apps/rhythmbox/plugins/jump-to-playing/active "true"
#/apps/nautilus
gconftool-2 --type string --set /apps/nautilus/preferences/show_icon_text "never"
gconftool-2 --type bool --set  /apps/nautilus/desktop/computer_icon_visible "true"
gconftool-2 --type bool --set  /apps/nautilus/desktop/home_icon_visible "true"
gconftool-2 --type bool --set  /apps/nautilus/desktop/trash_icon_visible "true"
# /desktop/gnome
gconftool-2 --type int --set /desktop/gnome/thumbnail_cache/maximum_age "7" # only allow thumbnails for 7 days

# theme
zenity --question --text "Do you want to use the custom Ubuntu Assistant theme?" --title="Ubuntu Assistant"
if [ $? -eq 0 ]; then
	gconftool-2 --type string --set /apps/metacity/general/button_layout "menu:minimize,maximize,close" # move buttons BACK to the right
	gconftool-2 --type string --set /apps/metacity/general/theme "Shiki-Colors-Easy-Metacity"
	gconftool-2 --type string --set /apps/metacity/general/titlebar_font "Patron Alt Medium 10"
	gconftool-2 --type string --set /apps/nautilus/preferences/desktop_font "Arial 9"
	gconftool-2 --type string --set /desktop/gnome/interface/font_name "Arial 9"
	gconftool-2 --type string --set /desktop/gnome/interface/gtk_color_scheme "fg_color:#000000000000
bg_color:#ededececebeb
text_color:#1a1a1a1a1a1a
base_color:#ffffffffffff
selected_fg_color:#ffffffffffff
selected_bg_color:#5b5b8080a7a7
tooltip_fg_color:#000000000000
tooltip_bg_color:#f5f5f5f5b5b5"
	gconftool-2 --type string --set /desktop/gnome/interface/gtk_theme "Clearlooks"
	gconftool-2 --type string --set /desktop/gnome/interface/icon_theme "elementary-monochrome"
fi


# better font rendering
echo 'true' > $HOME/.font.conf

