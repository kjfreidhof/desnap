# desnap

#!/bin/bash

# AUTHOR = Kyle Freidhof 

# Date created = /10/27/22

# License = GPL3

<<COMMENT
This script removes snap and all of its packages including the snap store and replaces snap with
with flatpak if the user wants to  
COMMENT

# see if user is root or not 
if [  $(whoami) = 'root' ]; then 
	echo "You are root"

else
	echo "you are not root"
	echo "make sure you run this script with sudo"
	echo "or you have root privilages"
	exit 

fi 





# skip varriable 
skip()
{


	echo "This proccess will be continued : $1"
	continue
	


}


# Warning about script 
echo "This script"
sleep 5s 
echo "will remove snap and replace it with flatpak in ubuntu"
sleep 5s 
echo "Warning i am not responsible for any damages to your system when you run this script"
sleep 5s 
echo "run this at your own risk"
sleep 5s 


# Tells the user if they want to exit or not 
echo "Do you want to exit this script?"
echo "y, Yes"
echo "n, No"


read -rp "= " CHOICE 

if [ "$CHOICE" = y ]; then 
	exit 	

elif [ "$CHOICE" = n ]; then
	eval "$skip_str"


else 
	eval "$skip_str"



fi

# removes all snap and snap packages 
snap remove firefox 
echo "Snap package removed"
sleep 5s
snap remove snap-store 
echo "Snap package removed"
sleep 5s 

cat remove.txt | xargs apt remove -y


echo "snapd is removed"
sleep 5s 

# gives the user option to reinstall if they want 
echo "before we continue would you like to reninstall snapd?"
echo "y, Yes"
echo "n, No"
echo "k, keep both"


read -rp "= " CHOICE 

if [ "$CHOICE" = y ]; then
	cat pkg.txt | xargs apt install -y
	exit 

elif [ "$CHOICE" = n ]; then 
	eval "$skip_str"

elif [ "$CHOICE" = k ]; then 
	cat pkg.txt | xargs apt install -y 
	eval "$skip_str"

else
	exit 


fi 

# gives user option to prevent snap from installing again 
echo "Do you want to prevent snap from installing again?"
echo "y, Yes"
echo "n, No"


read -rp "= " CHOICE 

if [ "$CHOICE" = y ]; then 
cat hold.txt | xargs apt-mark hold 
echo "snapd on hold"
sleep 5
echo "snap-store on hold"
sleep 5 
eval "$skip_str"

elif [ "$CHOICE" = n ]; then 
	echo "Do not prevent snap from installing"
	eval "$skip_str"

else 
	exit 

fi 


# asks user if they want tot install flatpak or not 

echo "Do you want to install flatpak or exit [1|2]"
echo "1, Install"
echo "2, exit"

read -rp "= " CHOICE 

if [ "$CHOICE" = 1 ]; then 
	echo "installing flatpak"
	eval "$skip_str"
0
elif [ "$CHOICE" = 2 ]; then
	exit 


else 
	exit 


fi 


# installs flatpak and reboots the machine if the user wishes  


cat flatpak.txt | xargs apt install -y

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


echo "Do you want to Reboot now or do it manually for flatpak to take affect? [1|2|]"
echo "1, Reboot"
echo "2, Manually"

read -rp "= " CHOICE 

if [ "$CHOICE" = 1 ]; then
	echo "Rebooting Now"
	sleep 3
	eval "$skip_str"

elif [ "$CHOICE" = 2 ]; then 
	exit

else 
	exit 


fi 

reboot 
















