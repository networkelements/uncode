#!/bin/sh

url=`cat $HOME/dlurlall.txt`
history="$HOME/gallery-dl-history.bin"
dl_directory="$HOME/gallery-dl/"
send_directory="s3://pic/gallery-dl/"
ls_s3directory_report="$HOME/s3ls.log"
ls_localdirectory_report="$HOME/local_ls.log"
disk_area01=/
area_limit01=90
process_name=s3cmd


while read line
do
    gallery-dl $line --download-archive $history
    s3cmd put --recursive $dl_directory $send_directory ; \
    count=`ps -ef | grep $process_name | grep -v grep | wc -l`
    
    if [ $count = 0 ]; then
    echo ""
    echo "* $process_name is Down"
    echo "------------------------------------"
    echo ""
    echo "* Delete gallery-dl directory is Start"
    echo "------------------------------------"
    echo ""
    rm -rf $dl_directory
    echo ""
    echo "* gallery-dl directory deleted"
    echo "------------------------------------"
    echo ""
else
    echo ""
    echo "* Disk space is OK"
    echo "------------------------------------"
    echo ""
fi
    
    
    
    
    disk_limit01=`df $disk_area01 | tail -1 | /bin/sed 's/^.* \([0-9]*\)%.*$/\1/'`
    if [ $disk_limit01 -gt $area_limit01 ]; then
        break
    fi
done << FILE
$url
FILE

echo ""
echo "* Downloaded !!!"
echo "------------------------------------"
echo ""


# s3cmd put --recursive $dl_directory $send_directory                          ; \
# s3cmd ls --recursive $send_directory > $ls_s3directory_report               ; \
# sed -i -e 's/^.*s3.*gallery-dl/gallery-dl/g' $ls_s3directory_report         ; \
# find $HOME/gallery-dl/ -type f | xargs -r ls -l > $ls_localdirectory_report ; \
# count=`ps -ef | grep $process_name | grep -v grep | wc -l`

count=`ps -ef | grep $process_name | grep -v grep | wc -l`


echo ""
echo "* Uploaded to Objectstorage"
echo "------------------------------------"
echo ""


if [ $count = 0 ]; then
    echo ""
    echo "* $process_name is Down"
    echo "------------------------------------"
    echo ""
    echo "* Delete gallery-dl directory is Start"
    echo "------------------------------------"
    echo ""
    rm -rf $dl_directory
    echo ""
    echo "* gallery-dl directory deleted"
    echo "------------------------------------"
    echo ""
else
    echo ""
    echo "* Disk space is OK"
    echo "------------------------------------"
    echo ""
fi

exit
