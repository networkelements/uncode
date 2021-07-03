#!/bin/sh

url=`cat $HOME/ghq/github.com/networkelements/uncode/shellscript/gallerydl-tool/dlurlall.txt`
historybin="$HOME/ghq/github.com/networkelements/uncode/shellscript/gallerydl-tool/gallery-dl-history.bin"
dl_directory="/mnt/data_drive/picdir/gallery-dl/"

# danbooru_directory="$HOME/gallery-dl/danbooru/"
# exhentai_directory="$HOME/gallery-dl/exhentai/"
# twitter_directory="$HOME/gallery-dl/twitter/"
# nijie_directory="$HOME/gallery-dl/nijie/"
# pixiv_directory="$HOME/gallery-dl/pixiv/"
# sankaku_directory="$HOME/gallery-dl/sankaku/"
# seiga_directory="$HOME/gallery-dl/seiga/"
# tumblr_directory="$HOME/gallery-dl/tumblr/"
# twitter_directory="$HOME/gallery-dl/twitter/"
# weibo_directory="$HOME/gallery-dl/weibo/"
# yandere_directory="$HOME/gallery-dl/yandere/"
# ls_s3directory_report="$HOME/s3ls.log"
# ls_localdirectory_report="$HOME/local_ls.log"
# disk_area01=/
# area_limit01=95
# process_name=s3cmd

send_directory01="/mnt/data_drive/picdir/"
send_directory02="/mnt/data_drive/conffolder/"

log_stdout=/var/log/gallery-dl/stdout.log
log_stderr=/var/log/gallery-dl/stderr.log

mkdir -p /var/log/gallery-dl

cd /mnt/data_drive/picdir


# # https://genzouw.com/entry/2020/01/06/120027/1845/
exec 1> >(
  while read -r l; do echo "[$(date +"%Y-%m-%d %H:%M:%S")] $l"; done \
    | tee -a $log_stdout
)
exec 2>>$log_stderr
# 1> $log_stdout 2> $log_stderr

while read line
do
    # download
    gallery-dl $line --download-archive $historybin
done << FILE
$url
FILE


echo "* Downloaded"
echo "------------------------------------"
echo ""
echo "* date"
echo "------------------------------------"
date

cp $historybin $send_directory02

# マウントのみ
# goofys --profile vultr --endpoint https://ewr1.vultrobjects.com picdir /vultr_picdir
# goofys --profile vultr --endpoint https://ewr1.vultrobjects.com conffolder /vultr_conffolder
# s3fs picdir /mnt/s3mnt -o rw,url=https://ewr1.vultrobjects.com

exit
