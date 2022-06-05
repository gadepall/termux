#!/bin/sh
choice=""
while [ "$choice" != 1 -a "$choice" != 2 ] ; do
echo "Options:"
echo "1. Firefox"
echo "2. w3m"
read -p "-> " choice
done
if [ "$choice" -eq 1 ] ; then
termux-open "$1"
else
w3m "$1"
fi
