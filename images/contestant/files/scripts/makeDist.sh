#!/usr/bin/env bash
# Cleans up temporary files, etc and makes it ready for imaging

UTILDIR="/icpc"

# Cleanup 'imageadmin' things
rm -rf /home/imageadmin
userdel imageadmin

# Delete proxy settings for apt(if any)
rm -f /etc/apt/apt.conf.d/01proxy

# Kill all the user processes(and wait for them to die)
killall -9 -u contestant
sleep 5

# Reset the team(and any defaults)
$UTILDIR/scripts/deleteUser.sh

# reset the TEAM and SITE
echo "" > $UTILDIR/TEAM
echo "fit" > $UTILDIR/SITE

# Remove the team wallpaper
rm -f $UTILDIR/teamWallpaper.png

# Delete the printers/printer class
for PRINTER in $(lpstat -v | cut -d ' ' -f 3 | tr -d ':')
do
  lpadmin -x $PRINTER
done
lpadmin -x ContestPrinter

# Cleanup apt cache/unnecessary package
apt-get autoremove --purge -y
apt-get clean

# Remove 'apt-get update' data
rm -rf /var/lib/apt/lists
mkdir -p /var/lib/apt/lists/partial

# enable the firewall
ufw --force enable

# Delete /etc/machine-id so the images generate a new one on boot
echo "" > /etc/machine-id
