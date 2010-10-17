#!/bin/bash

# Ubuntu Assistant - 10.10 (Maverick Meerkat)
# Install requested and required programs and libraries for a better
#     desktop experience
# Copyright (C) 2007-2010  Brett Alton <brett.jr.alton@gmail.com>
# Last edited 2010-10-17

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
	sudo apt-get install zenity
fi

sudo add-apt-repository ppa:banshee-team/ppa # Banshee Media Player
sudo add-apt-repository ppa:chromium-daily/stable # Chromium Web Browser
sudo add-apt-repository ppa:docky-core/ppa # Docky (package not yet installed below)
sudo add-apt-repository ppa:doctormo/groundcontrol # Ground Control
sudo add-apt-repository ppa:elementaryart/ppa # Elementary Art
sudo add-apt-repository ppa:gstreamer-developers/ppa # PiTiVi Video Editor
sudo add-apt-repository ppa:lernid-devs/lernid-releases # Lernid
sudo add-apt-repository ppa:openshot.developers/ppa # Openshot
sudo add-apt-repository ppa:pidgin-developers/ppa # Pidgin Instant Messenger
sudo add-apt-repository ppa:rabbitvcs/ppa # RabbitVCS (package not yet installed below)
sudo add-apt-repository ppa:jonls/redshift-ppa # Redshift (package not yet installed below)
sudo add-apt-repository ppa:savoirfairelinux # SFLPhone
sudo add-apt-repository ppa:team-xbmc/ppa # XBMC (package not yet installed below)
sudo add-apt-repository ppa:tiheum/equinox # Equinox theme and Faenza icon set
sudo add-apt-repository ppa:tualatrix/ppa # Ubuntu Tweak
sudo add-apt-repository ppa:ubuntu-wine/ppa # Ubuntu Wine
sudo add-apt-repository ppa:zeitgeist/ppa # Zeitgeist / GNOME Activity Journal (package not yet installed below)

# Medibuntu / https://help.ubuntu.com/community/Medibuntu
sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

# GetDeb / PlayDeb
PLAYDEB=playdeb_0.3-1~getdeb1_all.deb
GETDEB=getdeb-repository_0.1-1~getdeb1_all.deb

if [ ! -f $PLAYDEB ]; then
	wget --tries=1 http://archive.getdeb.net/install_deb/$PLAYDEB
fi

if [ $? -eq 0 ]; then
	if [ ! -f $GETDEB ]; then
		wget --tries=1 http://archive.getdeb.net/install_deb/$GETDEB
	fi

	if [ $? -eq 0 ]; then
		gksu dpkg -i $PLAYDEB $GETDEB
	
		if [ $? -eq 0 ]; then
			rm -f $PLAYDEB $GETDEB
			echo ' -- installed playdeb/getdeb repositories'
		else
			echo ' !! could not install playdeb/getdeb repositories!'
		fi
	else
		echo ' !! could not download getdeb repositories!'
	fi
else
	echo ' !! could not download playdeb repositories!'
fi

# update
gksu apt-get update

# upgrade
sudo apt-get safe-upgrade

# install
sudo apt-get install \
agave \
audacity \
banshee \
banshee-extension-alarm \
banshee-extension-coverwallpaper \
banshee-extension-lyrics \
banshee-extension-mirage \
cheese \
chromium-browser \
clive \
community-themes \
cups-pdf \
elementary-icon-theme \
elementary-theme \
elementary-wallpapers \
emesene \
equinox-theme \
equinox-ubuntu-theme \
faad \
faenza-icon-theme \
ffmpeg \
firefox-notify \
flashplugin-nonfree \
gimp \
gnome-backgrounds \
gnome-colors \
gnome-themes-extras \
gnome-themes-ubuntu \
gstreamer0.10-ffmpeg \
gstreamer0.10-plugins-bad \
gstreamer0.10-plugins-bad-multiverse \
gstreamer0.10-plugins-ugly \
gstreamer0.10-plugins-ugly-multiverse \
gtk2-engines-equinox \
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
openshot \
p7zip-full \
parcellite \
pidgin \
pidgin-facebookchat \
pidgin-libnotify \
pidgin-themes \
shiki-colors \
soundconverter \
startupmanager \
ttf-droid \
ubuntu-tweak \
ubuntu-wallpapers-extra \
unrar \
vlc \
wine1.3

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
		rm -f $HOME/start-here.png
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
	rm -fr $HOME/.gnome2/rhythmbox/plugins/jump-to-playing/
fi

# create rhytmbox directory if it does not exist
if [ ! -d $HOME/.gnome2/rhythmbox/plugins/ ]; then
	mkdir -p $HOME/.gnome2/rhythmbox/plugins/
fi

# extract downloaded file to rhythmbox plugins directory
if [ -f $HOME/jump-to-playing-0.3.1.tar.gz ]; then
	tar -xvzf jump-to-playing-0.3.1.tar.gz -C $HOME/.gnome2/rhythmbox/plugins/ &&
	rm -f $HOME/jump-to-playing-0.3.1.tar.gz
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
	rm -f $HOME/fonts-20100415.tar.gz
else
	echo ' !! fonts-20100415.tar.gz not found -- could not install!'
fi


# /apps/gnome-screenshot
gconftool-2 --type bool --set  /apps/gnome-screenshot/include_pointer "false" # turn off mouse pointer in screenshots
# /apps/rhythmbox
gconftool-2 --type bool --set /apps/rhythmbox/plugins/jump-to-playing/active "true"
#/apps/nautilus
gconftool-2 --type string --set /apps/nautilus/preferences/show_icon_text "never"
gconftool-2 --type bool --set  /apps/nautilus/desktop/home_icon_visible "true"
gconftool-2 --type bool --set  /apps/nautilus/desktop/trash_icon_visible "true"
# /desktop/gnome
gconftool-2 --type int --set /desktop/gnome/thumbnail_cache/maximum_age "7" # only allow thumbnails for 7 days

# theme
zenity --question --text "Do you want to use the custom Ubuntu Assistant theme?" --title="Ubuntu Assistant"
if [ $? -eq 0 ]; then
	gconftool-2 --type string --set /apps/metacity/general/theme "Radiance"
	gconftool-2 --type string --set /apps/metacity/general/titlebar_font "Ubuntu Italic 10"
	gconftool-2 --type string --set /apps/nautilus/preferences/desktop_font "Ubuntu 9"
	gconftool-2 --type string --set /desktop/gnome/interface/font_name "Ubuntu  9"
	gconftool-2 --type string --set /desktop/gnome/interface/gtk_theme "Clearlooks"
	gconftool-2 --type string --set /desktop/gnome/interface/icon_theme "elementary-monochrome"
fi
