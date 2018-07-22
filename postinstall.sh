#!/bin/bash

#Info: Simple script that installs additional useful programs to a Debian Netinstall installation.
#Author: cabi81
#Version: v0.1
#Date: 22/07/2018 

#Notes: Must be root to run this script!

if [ $EUID -ne 0 ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# Updating sources.list:
sudo sh -c 'echo "http://debian.mirror.digitalpacific.com.au/debian stable main contrib non-free" >> /etc/apt/sources.list'
sudo sh -c 'echo "http://security.debian.org/debian-security stable main contrib non-free" >> /etc/apt/sources.list'

# Updating repo:
sudo apt-get update -y
	
# Installing WM/X Windows:
sudo apt-get install i3 openbox obconf obmenu xorg compton -y
	
# Installing Admin tools:
sudo apt-get install ssh apt-transport-https htop gcc git dstat wireshark linux-headers-amd64 samba -y
	
# Installing Appearance/Theme tools:
sudo apt-get install lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lxappearance gtk-theme-switch gtk-chtheme qt4-qtconfig xfonts-terminus ttf-mscorefonts-installer fonts-liberation fonts-font-awesome conky tint2 neofetch dzen2 -y
	
# Installing Audio/Visual tools:
sudo apt-get install moc vlc pulseaudio -y
	
# Installing GUI tools:
sudo apt-get install pcmanfm nitrogen mupdf rofi gimp gcolor2 agave -y
	
# Installing Additional tools:
sudo apt-get install wicd feh ranger tar nano sakura unrar rar xarchiver scrot -y
	
# Installing Internet tools:
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update -y
sudo apt-get install google-chrome-stable filezilla -y
	
echo "Installation is now complete..."
