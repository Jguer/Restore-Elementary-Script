#!/bin/bash
#Original Header 
#2015 JustSomeDood
# copyright...yeah right just use it if you want.
# 
# Modified for personal use of Jguer, avoid using.

echo "Custom elementary install"

wait

echo "Adding ppas"

	sudo apt-add-repository -y ppa:justsomedood/justsomeelementary
	sudo apt-add-repository -y ppa:transmissionbt/ppa
	sudo add-apt-repository -y ppa:linrunner/tlp
	wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
	sudo wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo apt-get -y update
	sudo apt-get -y dist-upgrade

wait

echo "Installing apps"

	sudo apt-get install -y elementary-tweaks playonlinux gimp transmission-gtk sublime-text-installer gdebi firefox git

wait

read -p "Install tlp and settings? ONLY INTEL (y/n) " RESP
if [ "$RESP" = "y" ]; then
	echo "Installing TLP"
 	sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_pstate=enable acpi_osi=Linux i915.i915_enable_fbc=1"/g' /etc/default/grub
	 sudo update-grub
	 sudo apt-get install tlp tlp-rdw thermald
 	sudo mv tlp /etc/default
else
	echo "Skipping TLP"
fi

wait

read -p "Install Custom Touchpad Settings? (y/n) " RESP
if [ "$RESP" = "y" ]; then
	echo "Installing touchpad settings"
	sudo rm -rf /etc/X11/xorg.conf.d/
	sudo mkdir /etc/X11/xorg.conf.d/
	sudo mv 50-synaptics.conf /etc/X11/xorg.conf.d/
else
	echo "Skipping touchpad settings"
fi

	echo "Final update and clean (Check for network manager fuckery)"

wait
	sudo apt-get -y update
	sudo apt-get -y dist-upgrade
	sudo apt-get clean
	sudo apt-get autoremove
	sudo apt-get autoclean

read -p "Install Dropbox? (y/n) " RESP
if [ "$RESP" = "y" ]; then
	echo "Installing Dropbox"
	git clone https://github.com/zant95/elementary-dropbox /tmp/elementary-dropbox
	bash /tmp/elementary-dropbox/install.sh
else
	echo "Exiting"
fi


exit 0