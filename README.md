# kernelsANDboots
aaa_kernels, zzz_kernels

1) Suposed that you have autoslack-initrd and slackup-grub else do it..
2) Put aaa_kernels.sh and zzz_kernels.sh to /etc/rc.d/ Dont forget to made them executables (chmod +x)
3) take a backup your /etc/rc.6 and replace it or modified as mine
4) cat my rc.local >> to your /etc/rc.d/rc.local
5) reboot

# NOTES
Works only if grub = bootloader
# NOTE!!!
Keep your mind on Slackware updates. If a/sysvinit-scripts upgraded or rebuilded from Pat,
then if you overwrite your /etc/rc.d/rc.6 commands you must edit it again... 

# why?
You will have everything autoslack-initrd and slackup-grub giving plus always a second official slackware kernel no matter what upgradepkg do...
