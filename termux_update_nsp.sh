#!/bin/sh

# Updated Bash Script to fix a bunch of issues like no error checking

# Check if apt or pacman is used, then update the system, and exit if update failed (exit code = 1)
case $TERMUX_APP_PACKAGE_MANAGER in
	apt) apt update && apt upgrade || exit 1;;
	pacman) pacman -Syu || exit 1;;
	*) pkg upgrade || exit 1;;
esac

pkg i bash cmake make vim clang git binutils

mkdir SwitchUpdatePatcher
cd SwitchUpdatePatcher

curl -o nsp_update_patcher.sh https://gist.githubusercontent.com/Vixeliz/eb2f038d59beafff14e49b56c14e469c/raw/a88f012227fb703e5b0a009d01a6f7670f5ba3e4/nsp_update_patcher.sh
chmod +x nsp_update_patcher.sh

git clone https://github.com/SciresM/hactool
mv hactool hactoolsrc
cd hactoolsrc
git checkout c2c907430e674614223959f0377f5e71f9e44a4a
mv config.mk.template config.mk
sed -i '372d' main.c
mv main.temp main.c
make
mv hactool ..
cd ..

git clone https://github.com/The-4n/hacPack
cd hacPack
git checkout 7845e7be8d03a263c33430f9e8c2512f7c280c88
mv config.mk.template config.mk
make
mv hacpack ..
cd ..
