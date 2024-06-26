#!/usr/bin/bash

TERMUX_VERSION="0.118.0"
apt install inetutils-ping 

servers=("google.com" "raw.githubusercontent.com")

for server in "${servers[@]}"; do
    if ! ping -c 1 -W 3 "$server"&> /dev/null; then
        echo -e "\e[1;31m$server is not reachable with your current network.\nChange your network configuration.\e[0m"
    fi
done

if [ -z "$TERMUX_VERSION" ]; then
    echo -e "\e[1;31mTermux not detected !!\e[0m\n\e[1;31mInstall aborted !!\e[0m"
    exit 1
fi

if [ -d "$HOME/Revancify-ubuntu" ]; then
    ./Revancify-ubuntu/revancify
    exit 0
fi

if ! command -v git &> /dev/null; then
    if ! apt update -y -o Dpkg::Options::="--force-confnew"; then
        echo -e "\e[1;31mOops !!
Possible causes of error:
1. Termux from Playstore is not maintained. Download Termux from github.
2. Unstable internet Connection.
3. Repository issues. Clear Termux Data and retry."
        exit 1
    fi
    apt install git -y -o Dpkg::Options::="--force-confnew"
fi

if git clone --depth=1 https://github.com/Lex9z/Revancify-ubuntu.git; then
    $HOME/Revancify-ubuntu/revancify
else
    echo -e "\e[1;31mInstall Failed !!\e[0m"
    echo "Please Try again"
    exit 1
fi
