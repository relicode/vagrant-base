#!/bin/sh

export OC_PULSE_USERNAME=""
export OC_PULSE_PASSWORD=""
export OC_PULSE_VPN_URL=""

if [ ! $(which openconnect) ]; then echo "Openconnect not found. Install with \"sudo apt install -y openconnect\"."; exit 1; fi
if [ $(id -u) -ne 0 ]; then echo "Please run as root."; exit 1; fi

echo "${OC_PULSE_PASSWORD}" | openconnect --protocol=pulse --user="${OC_PULSE_USERNAME}" "${OC_PULSE_VPN_URL}"
