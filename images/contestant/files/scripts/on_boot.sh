#!/bin/bash

# Ignore SIGHUP, sometimes systemd sends it to us shortly after
# boot and that kills us.
trap '' HUP

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

cat << EOF

    ___ _  _ _       ___ _
   / __| || (_)_ __ / __(_)___
  | (__| __ | | '_ \ (__| / -_)
   \___|_||_|_| .__/\___|_\___|
              |_|

EOF

su - -c /icpc/scripts/set_hostname.sh

su - -c /icpc/scripts/self_test

if [ -f /icpc/setup_complete ]; then
  # nothing to do, setup is already done(but still let it run with -f or --force)
  echo "Already configured."
  exit
fi

read -r -p "Do you want to run icpc_setup? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then
    /icpc/scripts/icpc_setup.sh
fi
