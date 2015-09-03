#!/bin/bash

#TODO:

# http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers

# Basic set up Ubuntu Server
echo "Welcome, I will now begin configuring you're fresh Ubuntu Server!"

# Set encoding
sudo locale-gen UTF-8

# Create admin user
echo "Let's create another user that will administer this server and give it some root privileges."
read username
adduser $username #create new user
gpasswd -a $username sudo #add the new user to sudo group
sudo update-alternatives --config editor #change visudo to use vim
sudo visudo # add "$username $ALL=NOPASSWD: ALL" to the end of the file to stop asking for sudo password
echo "Now issue a ssh-copy-id $username@SERVER_IP_ADDRESS from you're local machine to add ssh-key to the new user"

# Update and upgrade Ubuntu
echo "Lets get started with everything up to date"
apt-get update
apt-get upgrade

# Install Fail2ban
echo "Fail2ban is a daemon that monitors login attempts to a server and blocks suspicious activity as it occurs."
apt-get install fail2ban

# Install Logwatch
apt-get install logwatch
echo "/usr/sbin/logwatch --output mail --mailto luandro@gmail.com --detail high" >> /etc/cron.daily/00logwatch

# Lock down SSH
vim /etc/ssh/sshd_config

service ssh restart

# Setting up firewall
serverip=ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo "Configuring firewall for ip $ip"
ufw allow from $ip to any port 22
ufw allow 80
ufw allow 443
ufw enable

#Enable Automatic Security Updates
echo "Enabling automatic secutiry updates"
apt-get install unattended-upgrades

vim /etc/apt/apt.conf.d/10periodic
echo "make it look like this"
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";

vim /etc/apt/apt.conf.d/50unattended-upgrades
echo "make it look like this"
Unattended-Upgrade::Allowed-Origins {
        "Ubuntu lucid-security";
//      "Ubuntu lucid-updates";
};

# Install Git
echo "Do you wish to install Git"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) apt-get install git; break;;
        No ) exit;;
    esac
done

# Create swap file
# does the swap file already exist?
grep -q "swapfile" /etc/fstab
# if not then create it
if [ $? -ne 0  ]; then
    echo "Swapfile not found. Let's add one."
    read -p "Swapfile size " userswapsize
    swapsize=$userswapsize
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
