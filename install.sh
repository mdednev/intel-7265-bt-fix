#!/bin/bash

script_path=$(cd $(dirname $0); pwd)

set -e

echo "Installing udev rules"

cp -i ${script_path}/udev/99-intel7265-aspm-aer.rules /etc/udev/rules.d

echo "Installing script file"
mkdir --parents /usr/local/sbin
cp -i ${script_path}/scripts/intel-wifi-aspm+aer-fix /usr/local/sbin

udevadm control --reload
