#!/bin/bash
# Basic set up Ubuntu Server

echo "Welcome, I will now begin configuring you're fresh Ubuntu Server!"

# Setup secure password
echo "Fist let's change the root password to something long and complex. You won’t need to remember it, just store it somewhere secure - this password will only be needed if you lose the ability to log in over ssh or lose your sudo password."
read password
passwd $password

# Update and upgrade Ubuntu
echo "Now lets get started with everything up to date"
apt-get update
apt-get upgrade

# Install Fail2ban
echo "Fail2ban is a daemon that monitors login attempts to a server and blocks suspicious activity as it occurs."
apt-get install fail2ban

# Setup new login
echo "Now, let’s set up your login user."
read -p "Login user: " name
name=${name:-admin}
useradd $name
mkdir /home/$name
mkdir /home/$name/.ssh
chmod 700 /home/$name/.ssh
# echo "This is the password you’ll use to sudo."
# read -p "$name user password:" userpassword
# passwd $name

# Lock down SSH
vim /etc/ssh/sshd_config

service ssh restart

# Setting up firewall
ip=ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo "Configuring firewall for ip $ip"
ufw allow from $ip to any port 22
ufw allow 80
ufw allow 443
ufw enable

#Enable Automatic Security Updates
echo "Enabling automatic secutiry updates"
apt-get install unattended-upgrades
vim /etc/apt/apt.conf.d/10periodic

# Install Git
echo "Do you wish to install Git"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) apt-get install git; break;;
        No ) exit;;
    esac
done

# Create swap file

swapsize=512
# does the swap file already exist?
grep -q "swapfile" /etc/fstab
# if not then create it
if [ $? -ne 0  ]; then
    echo 'swapfile not found. Adding swapfile.'
    fallocate -l ${swapsize}M /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
    echo 'swapfile found. No changes made.'
fi
# output results to terminal
cat /proc/swaps
cat /proc/meminfo | grep Swap
