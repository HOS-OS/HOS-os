#!/bin/bash

echo "   Welcome to Hos OS update 3.2  This update will update your system and also add 3 new features to your computer. the 3 new features are Bluetooth support and also new screen support for monitors, also better battey life. Do you wish to install Hos OS update 3.2? after installation, your computer will automatically restart.   "
select yn in "Yes" "No"; do
    case $yn in
Yes ) sudo apt update ; sudo apt install -y tlp ; sudo apt-get install - y blueman; sudo apt-get install -y lxrandr ; sed -i 's/DISTRIB_DESCRIPTION="Hos OS 3.1"/DISTRIB_DESCRIPTION="Hos OS 3.2"/' /etc/lsb-release ; sed -i 's/NAME="Ubuntu"/NAME="HOS OS"/' /usr/lib/os-release  ; sed -i 's/PRETTY_NAME="HOS OS BETA  Live CD"/PRETTY_NAME="Hos OS 3.2"/' /usr/lib/os-release ; 

 echo "-> finished. your computer will reboot in 5 min seconds"; secs=$((100* 60))
while [ $secs -gt 0 ]; do
   echo -ne "$secs\033[0K\r"
   sleep 1
   : $((secs--))
done; sudo reboot;;
 
 No ) exit;;
    esac
done