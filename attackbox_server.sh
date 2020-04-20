#!/bin/bash
cat banner.txt

echo "Before Running Make Sure DNS Has Been Set for This Server"
echo "If DNS Set Please Press ENTER to Continue"
read something

echo ""
echo "Before Continuing Set The SSH Configuration To Allow for Password Authentication"
echo "We Will Change This Back to Key Based Authentication Following Configuration of On-Site Machine"
echo "Please Press ENTER When Complete"
read something

echo ""
echo "Checking if User is root or sudo..."
echo ""
if [[ $EUID > 0 ]]; then
    echo "[!] Please run this script as root or sudo"
    exit
else
    echo "[*] Updating Apt Repos and Packages"
    echo ""
    apt update && apt upgrade -y
    echo ""
    echo "[*] Setting root Password"
    echo ""
    passwd
    echo ""
    echo "[*] Creating SSH Directory and authorized_keys File for root User"
    echo "This User Will Be Utilized By The Onsite Machine to Reverse SSH Into This Machine on Boot."
    mkdir /root/.ssh
    touch /root/.ssh/authorized_keys
fi

echo ""
echo "After SSH Keys Transfered from Onsite Machine, Make Sure to Reconfigure SSH to Only Accept Key Based Authentication"
echo "[*] Complete!"
echo ""
