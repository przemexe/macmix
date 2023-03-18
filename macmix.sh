#!/bin/bash
if [ "$EUID" -ne 0 ]; then
  exit 1
fi

interface="eth0"
set_random_mac() {
  ip link set dev "$interface" down
  random_mac=$(printf '02:%02X:%02X:%02X:%02X:%02X' $(($RANDOM % 256)) $(($RANDOM % 256)) $(($RANDOM % 256)) $(($RANDOM % 256)) $(($RANDOM % 256)))
  ip link set dev "$interface" address "$random_mac"
  ip link set dev "$interface" up
}

while true; do
  set_random_mac
  sleep 20
done
