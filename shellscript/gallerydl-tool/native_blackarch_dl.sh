#!/bin/sh

url=`cat /mnt/data_drv/git/github.com/networkelements/uncode/shellscript/gallerydl-tool/dlurlall.txt`
historybin="/mnt/data_drv/git/github.com/networkelements/uncode/shellscript/gallerydl-tool/gallery-dl-history.bin"
dl_directory="/mnt/data_drv/picdir/gallery-dl/"

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

send_directory01="/mnt/data_drv/picdir/"
send_directory02="/mnt/data_drv/conffolder/"

# log_stdout=/var/log/gallery-dl/stdout.log
# log_stderr=/var/log/gallery-dl/stderr.log
log_gallery=/var/log/gallery-dl/gallery.log

mkdir -p /var/log/gallery-dl

cd /mnt/data_drv/picdir


# https://genzouw.com/entry/2020/01/06/120027/1845/
# https://qiita.com/YumaInaura/items/e3a19c6e2815d7deee33
# http://capm-network.com/?tag=%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88-%E3%83%AD%E3%82%B0%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90
# https://pokuwagata.hatenablog.com/entry/2018/12/03/002804

exec 2>&1> >(
  while read -r l; do echo "[$(date +"%Y-%m-%d %H:%M:%S")] $l"; done \
    | tee -a $log_gallery
)

# exec 2>>$log_stderr
2>&1> $log_gallery

while read line
do
  # download
  # https://gist.github.com/mori-dev/613034
  if [ `echo $line | grep "twitter.com"` ]; then
    gallery-dl $line --download-archive $historybin
    
    # https://linuxfan.info/cat-string-in-shell
    line="$line/media"
    gallery-dl $line --download-archive $historybin
  else
    gallery-dl $line --download-archive $historybin
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

cp $historybin $send_directory02

# マウントのみ
# goofys --profile vultr --endpoint https://ewr1.vultrobjects.com picdir /vultr_picdir
# goofys --profile vultr --endpoint https://ewr1.vultrobjects.com conffolder /vultr_conffolder
# s3fs picdir /mnt/s3mnt -o rw,url=https://ewr1.vultrobjects.com

exit
