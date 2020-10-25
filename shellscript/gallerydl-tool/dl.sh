#!/bin/sh

disk_area01=/
area_limit01=90
disk_limit01=`df $disk_area01 | tail -1 | /bin/sed 's/^.* \([0-9]*\)%.*$/\1/'`

url=`cat dlurlall.txt`
history="$HOME/gallery-dl-history.bin"

while read line
do
    gallery-dl $line --download-archive $history
    if [ $disk_limit01 -gt $area_limit01 ]; then
	break
    fi
done << FILE
$url    
FILE

s3cmd put --recursive $HOME/gallery-dl/ s3://mybucket/gallery-dl/

exit
