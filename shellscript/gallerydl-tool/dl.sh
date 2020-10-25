#!/bin/sh

url=`cat $HOMEdlurlall.txt`
history="$HOME/gallery-dl-history.bin"
dl_directory="$HOME/gallery-dl/"
send_directory="s3://mybucket/gallery-dl/"
disk_area01=/
area_limit01=90
disk_limit01=`df $disk_area01 | tail -1 | /bin/sed 's/^.* \([0-9]*\)%.*$/\1/'`
count=`ps -ef | grep $process_name | grep -v grep | wc -l`
process_name=s3cmd


while read line
do
    gallery-dl $line --download-archive $history
    if [ $disk_limit01 -gt $area_limit01 ]; then
	break
    fi
done << FILE
$url    
FILE

s3cmd put --recursive $dl_directory $send_directory

if [ $count = 0 ]; then

  echo "$process_name is Down"
  echo "Delete gallery-dl directory is Start"
  rm -rf $dl_directory
else
  echo "Disk space is OK"
fi

exit
