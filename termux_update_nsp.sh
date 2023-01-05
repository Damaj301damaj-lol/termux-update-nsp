#!/bin/sh

# Updated Bash Script to fix a bunch of issues like no error checking

# Check if apt or pacman is used, then update the system, then install dependencies and exit if update failed (exit code = 1)
case $TERMUX_APP_PACKAGE_MANAGER in
	apt) apt update && apt upgrade && apt install cmake make clang binutils || echo "Failed!, don't decline updates/installations!" && exit 1;;
	pacman) pacman -Syu && pacman -S cmake make clang binutils || echo "Failed!, don't decline updates/installations!" && exit 1;;
	*) pkg upgrade && pkg install cmake make clang binutils || echo "Failed!, don't decline updates/installations!" && exit 1;;
esac

# Making a temp dir to build packages
mkdir temp && echo "make sure you are in the git repo!" || continue

# Installing the dependencies and compiling them!

# hactool
cd hactool
make || echo "Compilation Failed!, please report this bug at https://github.com/Damaj301damaj-lol/termux-update-nsp" && exit 1
mv hactool ..
cd ..
# hacpack
cd hacPack
make || echo "Compilation Failed!, please report this bug at https://github.com/Damaj301damaj-lol/termux-update-nsp" && exit 1
mv hacpack ..
cd ..

# now exit the temp folder
cd ..

# curl the script to save it
curl -O https://gist.github.com/Vixeliz/eb2f038d59beafff14e49b56c14e469c/raw/a88f012227fb703e5b0a009d01a6f7670f5ba3e4/nsp_update_patcher.sh || echo "Make sure you are online!" && exit 1
# chmod +x it
chmod +x nsp_update_patcher.sh

# print our status!
echo "We are Done!, do NOT remove anything from this dir, now, you can patch your games with ./nsp_update_patcher.sh BASE UPDATE"

# exit with a good exit code
exit 0
