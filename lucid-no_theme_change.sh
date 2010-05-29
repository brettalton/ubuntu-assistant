#!/bin/bash

# Ubuntu Assistant - 10.04 (Lucid Lynx)
# Install requested and required programs and libraries for a better
#     desktop experience
# Copyright (C) 2007-2010  Brett Alton <brett.jr.alton@gmail.com>
# Last edited 2010-05-10

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

sudo add-apt-repository ppa:banshee-team/ppa # Banshee Media Player
sudo add-apt-repository ppa:chromium-daily/ppa # Chromium Web Browser
sudo add-apt-repository ppa:docky-core/ppa # Docky (package not yet installed below)
sudo add-apt-repository ppa:doctormo/groundcontrol # Ground Control
sudo add-apt-repository ppa:gstreamer-developers/ppa # PiTiVi Video Editor
sudo add-apt-repository ppa:lernid-devs/lernid-releases # Lernid
sudo add-apt-repository ppa:openshot.developers/ppa # Openshot
sudo add-apt-repository ppa:pidgin-developers/ppa # Pidgin Instant Messenger
sudo add-apt-repositroy ppa:rabbitvcs/ppa # RabbitVCS
sudo add-apt-repository ppa:savoirfairelinux # SFLPhone
sudo add-apt-repository ppa:team-xbmc/ppa # XBMC (package not yet installed below)
sudo add-apt-repository ppa:tualatrix/ppa # Ubuntu Tweak
sudo add-apt-repository ppa:ubuntu-wine/ppa # Ubuntu Wine
sudo add-apt-repository ppa:zeitgeist/ppa # Zeitgeist / GNOME Activity Journal (package not yet installed below)

# Medibuntu / https://help.ubuntu.com/community/Medibuntu
sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

# GetDeb / PlayDeb
PLAYDEB=playdeb_0.3-1~getdeb1_all.deb
GETDEB=getdeb-repository_0.1-1~getdeb1_all.deb

if [ ! -f $PLAYDEB ]; then
	wget http://archive.getdeb.net/install_deb/$PLAYDEB
fi

if [ ! -f $GETDEB ]; then
	wget http://archive.getdeb.net/install_deb/$GETDEB
fi

sudo dpkg -i $PLAYDEB $GETDEB

if [ $? -eq 0 ]; then
	rm $PLAYDEB $GETDEB
else
	echo ' !! could not install playdeb/getdeb repositories!'
fi

# update
sudo aptitude update &&

# upgrade
sudo aptitude upgrade &&

# install
sudo aptitude install \
agave \
audacity \
banshee \
banshee-extension-alarm \
banshee-extension-coverwallpaper \
banshee-extension-lyrics \
banshee-extension-mirage \
cheese \
clive \
community-themes \
cups-pdf \
emesene \
faad \
ffmpeg \
flashplugin-nonfree \
gimp \
gnome-backgrounds \
gnome-themes-extras \
gnome-themes-ubuntu \
gstreamer0.10-ffmpeg \
gstreamer0.10-plugins-bad \
gstreamer0.10-plugins-bad-multiverse \
gstreamer0.10-plugins-ugly \
gstreamer0.10-plugins-ugly-multiverse \
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
pidgin-themes \
secure-delete \
soundconverter \
startupmanager \
ubuntu-tweak \
ubuntu-wallpapers-extra \
unrar \
vlc \
wine1.2 \
gnome-colors \
shiki-colors &&

# install elementary icons
cd $HOME
if [ ! -f $HOME/elementary.tar.gz ]; then
	wget http://staging.altonlabs.com/ubuntu_assistant/elementary.tar.gz
else
	' -- elementary.tar.gz already exists, skipping download'
fi

if [ ! -f $HOME/elementary-monochrome.tar.gz ]; then
	wget http://staging.altonlabs.com/ubuntu_assistant/elementary-monochrome.tar.gz
else
	' -- elementary-monochome.tar.gz already exists, skipping download'
fi

# make sure the file downloaded properly
if [ $? -ne 0 ]; then
	echo ' !! Could not download elementary icons!'
fi

# delete old elementary folder, if it exists
if [ -d /usr/share/icons/elementary/ ]; then
	sudo rm -r /usr/share/icons/elementary/
fi

# delete old elementary-monochrome folder, if it exists
if [ -d /usr/share/icons/elementary-monochrome/ ]; then
	sudo rm -r /usr/share/icons/elementary-monochrome/
fi

# extract downloaded files to /usr/share/icons/ directory
if [ -f $HOME/elementary.tar.gz ]; then
	sudo tar -xvzf elementary.tar.gz -C /usr/share/icons/ &&
	rm $HOME/elementary.tar.gz
else
	echo ' !! elementary.tar.gz not found -- could not install!'
fi

if [ -f $HOME/elementary-monochrome.tar.gz ]; then
	sudo tar -xvzf elementary-monochrome.tar.gz -C /usr/share/icons/ &&
	rm $HOME/elementary-monochrome.tar.gz
else
	echo ' !! elementary-monocrhome.tar.gz not found -- could not install!'
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
# /apps/metacity
gconftool-2 --type string --set /apps/metacity/general/button_layout "menu:minimize,maximize,close" # move buttons BACK to the right
# /apps/rhythmbox
gconftool-2 --type bool --set /apps/rhythmbox/plugins/jump-to-playing/active "true"
# /apps/nautilus
gconftool-2 --type bool --set  /apps/nautilus/desktop/computer_icon_visible "true"
gconftool-2 --type bool --set  /apps/nautilus/desktop/home_icon_visible "true"
gconftool-2 --type bool --set  /apps/nautilus/desktop/trash_icon_visible "true"
# /desktop/gnome
gconftool-2 --type int --set /desktop/gnome/thumbnail_cache/maximum_age "60" # only allow thumbnails for 60 days

# better font rendering
echo 'true' > $HOME/.font.conf
