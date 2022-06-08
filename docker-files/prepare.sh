#!/bin/bash
set -x
# RUN this as root 
PGPW=$(/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id)
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi
if (( EUID != 0 )); then
    echo "You must be root to do this." 1>&2
    exit 1
fi
# Change file names, so that after git pull config files wont be overwritten with dummy domain
sudo cp ../docker-volumes/etc/nginx/conf.d/default.conf.dummy ../docker-volumes/etc/nginx/conf.d/default.conf

#create .env file for fqdn and password
sudo cat - <<EOF > .env
FQDN=$1
EOF

/usr/local/bin/docker-compose up -d 