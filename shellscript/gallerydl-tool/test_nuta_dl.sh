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

# log_stdout=/var/log/gallery-dl/stdout.log
# log_stderr=/var/log/gallery-dl/stderr.log
log_gallery=/var/log/gallery-dl/gallery.log

mkdir -p /var/log/gallery-dl

cd /mnt/data_drive/picdir

while read line
do
  # download
  # https://gist.github.com/mori-dev/613034
  if [ `echo $line | grep "twitter.com"` ]; then
    echo $line
    
    # https://linuxfan.info/cat-string-in-shell
    line="$line /media"
    echo $line
  else
    echo $line
  fi
done << FILE
$url
FILE


echo "* Downloaded"
echo "------------------------------------"
echo ""
echo "* date"
echo "------------------------------------"
date


# マウントのみ
# goofys --profile vultr --endpoint https://ewr1.vultrobjects.com picdir /vultr_picdir
# goofys --profile vultr --endpoint https://ewr1.vultrobjects.com conffolder /vultr_conffolder
# s3fs picdir /mnt/s3mnt -o rw,url=https://ewr1.vultrobjects.com

exit
