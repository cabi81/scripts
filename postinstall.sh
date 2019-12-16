#!/bin/bash

#Info: Simple script that installs additional useful programs to a Debian Netinstall installation.
#Author: cabi81
#Version: v0.2
#Date: 16/12/2019 

##########
# History
#
# v0.1 - Initial Release (22/07/2018)
# v0.2 - Added Updating sources.list (16/12/2019)
#        Added ACYLS Fonts (16/12/2019)
#        Enabling LightDM
#        Added Reboot
#	 Removed agave
#	 Added User-specific Openbox
#
#
##########

#Notes: Must be root to run this script!

if [ $EUID -ne 0 ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# Updating sources.list:
if [ -f /etc/apt/sources.list ]; then
	sed -i 's|main|main contrib non-free|g' /etc/apt/sources.list
fi

sleep 10s

# Updating repo:
apt-get update -y

# Installing WM/X Windows:
apt-get install i3 openbox obconf obmenu xorg compton -y

# Installing Admin tools:
apt-get install ssh sudo screen apt-transport-https htop gcc git dstat wireshark linux-headers-amd64 samba -y

# Installing Appearance/Theme tools:
apt-get install lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lxappearance gtk-theme-switch gtk-chtheme qt4-qtconfig xfonts-terminus ttf-mscorefonts-installer fonts-liberation fonts-font-awesome conky tint2 neofetch dzen2 arc-theme xdg-user-dirs rxvt-unicode numix-gtk-theme -y

# Installing Audio/Visual tools:
apt-get install moc vlc pulseaudio pavucontrol -y

# Installing GUI tools:
apt-get install pcmanfm nitrogen mupdf rofi gimp gcolor2 -y

# Installing Additional tools:
apt-get install wicd feh ranger tar nano sakura unrar rar xarchiver scrot alsa-utils -y

# Installing Internet tools:
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update -y
apt-get install google-chrome-stable filezilla -y

# Installing Fonts:
git clone https://github.com/worron/ACYLS.git ~/.icons/ACYLS

echo "Installation is now complete..."

# Enabling LightDM:
systemctl enable lightdm

# User-specific Openbox:
echo "Type in a username that you will be using for your home directory"
read varname
echo "Changes will be applied to $varname username."
cp -r /etc/xdg/openbox/ /home/$varname/.config/
echo "Done!"

# Reboot
echo "System will now reboot!"
sleep 10s
reboot
