#!/bin/bash

# Anagnostakis Ioannis GR Crete 8/2023
# This script ran every time new kernel release is to be installaded in a Slackware system via upgradepkg...
# So lets name it aaa_kernels
# The idea is that  upgradepkg dont touch entries in nitrd.gz
# so only vmlinuz* files need to be restored after upgradepkg upgrade kernel
# and /lib/modules/old_kernel_version

# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

if [ "$EUID" -ne 0 ];then
echo "ROOT ACCESS PLEASE OR GO HOME..."
exit 1
fi

KERNEL2="$(uname -r)"
FILE1=vmlinuz-
DIR=/boot/BAK2
DIR1=/boot
DIR3=/lib/modules

if [ -d "$DIR" ]
then
echo "aaa_kernels: NO UPDATES"
else
echo "$KERNEL2"
# mkdir -p not needed , if needed then something is going wrong
echo "First time aaa_kernels ran here"
echo "or kernel was upgraded."
echo "Creating back-up files..."
mkdir "$DIR" || exit
wait
# Taking vmlinuz-* backup
cp "$DIR1"/"$FILE1"* "$DIR"/ 
wait
rm "$DIR"/vmlinuz-generic
# backup modules 
cp -a "$DIR3"/"$KERNEL2" "$DIR"/ 
wait
rm "$DIR"/vmlinuz-huge
echo ""
echo "aaa_kernels DB CREATED OK"
echo ""
fi

