#!/bin/sh

export USERNAME=""
export PASSWORD=""
export VPN_URL=""

if [ ! $(which openconnect) ]; then echo "Openconnect not found. Install with \"sudo apt install -y openconnect\"."; exit 1; fi
if [ $(id -u) -ne 0 ]; then echo "Please run as root."; exit 1; fi

echo "${PASSWORD}" | openconnect --protocol=pulse --user="${USERNAME}" "${VPN_URL}"
