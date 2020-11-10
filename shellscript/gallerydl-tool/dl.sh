#!/bin/sh

url=`cat $HOME/dlurlall.txt`
history="$HOME/gallery-dl-history.bin"
dl_directory="$HOME/gallery-dl/"
send_directory="s3://pic/gallery-dl/"
disk_area01=/
area_limit01=90
process_name=s3cmd


while read line
do
    gallery-dl $line --download-archive $history
    disk_limit01=`df $disk_area01 | tail -1 | /bin/sed 's/^.* \([0-9]*\)%.*$/\1/'`
    if [ $disk_limit01 -gt $area_limit01 ]; then
        break
    fi
done << FILE
$url
FILE

echo "Downloaded !!!"
echo "------------------------------------"
echo ""


s3cmd put --recursive $dl_directory $send_directory ; count=`ps -ef | grep $process_name | grep -v grep | wc -l`


echo "Uploaded to Objectstorage"
echo "------------------------------------"
echo ""


if [ $count = 0 ]; then
    echo "$process_name is Down"
    echo "------------------------------------"
    echo ""
    echo "Delete gallery-dl directory is Start"
    echo "------------------------------------"
    echo ""
    rm -rf $dl_directory
    echo "gallery-dl directory deleted"
    echo "------------------------------------"
    echo ""
else
    echo "Disk space is OK"
    echo "------------------------------------"
    echo ""
fi

exit
