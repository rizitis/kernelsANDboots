#!/bin/bash

# This script must ran after upgradepkg upgrade kernel , after autoslack-initrd AND 
# if aaa_kernels.sh is installed too, else this script have no use.
# So lets name it zzz_kernels
# initrd.gz keeps old entries after upgradepkg upgrade kernel so its ok
# only vmlinuz-(huge,generic)-old_kernel_version need to be backup and /lib/modules 
# NOTE: grub-mkconfig must run after this script add command at the end of this script 
# or if you have slackup-grub installed then slackup-grub must ran last.

# root
if [ "$EUID" -ne 0 ];then
echo "ROOT ACCESS PLEASE OR GO HOME..."
exit 1
fi

KERNEL2="$(uname -r)"
FILE=vmlinuz-
DIR=/boot/BAK2
DIR1=/boot
DIR3=/lib/modules
dir=/usr/local/zzz_kernels
file=/usr/local/zzz_kernels/zzz_kernels.TXT
file2=/usr/local/zzz_kernels/zzz_kernels.BAK


if [ -d "$dir" ]
then
echo "zzz_kernels in progress"
else
# this is only for the first time... so -p not needed , if needed then something going wrong
echo "Looks like its the first time zzz_kernels ran here"
mkdir "$dir" || exit
/bin/ls -tr /var/log/pkgtools/removed_scripts/ | grep kernel | tail -2 > "$file"
echo "DONE"
exit
fi

echo "$KERNEL2"
cd "$dir" || exit
if [ -f /usr/local/zzz_kernels/zzz_kernels.TXT ]
then 
mv "$file" "$file2" || exit
else 
echo "************************************"
echo "Something went wrong, ATTENSION... *"
echo "************************************"
exit
fi

set -e

if [ -f "$file2" ]
then 
/bin/ls -tr /var/log/pkgtools/removed_scripts/ | grep kernel | tail -2 > "$file"
fi

if cmp -s zzz_kernels.TXT zzz_kernels.BAK ; then
echo "zzz_kernels: NO KERNEL UPDATE WAS FOUND"
exit
elif
echo "zzz_kernels: KERNEL WAS UPDATED, DOING STUFF..."
then
cp "$DIR1"/"$FILE"* "$DIR"/
cp -a "$DIR1"/"$KERNEL2" "$DIR3"
rm -r "$DIR"
echo ""
echo "zzz_kernels finish, OK"
echo ""
else
 echo "********************************************************"
echo "Something went wrong!"
echo "Before shutdown check you have"
echo "a Linux-kernel installed a valid initrd and update-grub"
echo "********************************************************"
exit
fi

# Here in can be placed update-grub command
# I have slackup-grub for that job, skip this step
# grub-mkconfig -o /boot/grub/grub.cfg
