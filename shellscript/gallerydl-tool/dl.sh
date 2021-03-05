#!/bin/sh

url=`cat $HOME/git/github/uncode/shellscript/gallerydl-tool/dlurlall.txt`
historybin="$HOME/git/github/uncode/shellscript/gallerydl-tool/gallery-dl-history.bin"
dl_directory="$HOME/gallery-dl/"

danbooru_directory="$HOME/gallery-dl/danbooru/"
exhentai_directory="$HOME/gallery-dl/exhentai/"
twitter_directory="$HOME/gallery-dl/twitter/"
nijie_directory="$HOME/gallery-dl/nijie/"
pixiv_directory="$HOME/gallery-dl/pixiv/"
sankaku_directory="$HOME/gallery-dl/sankaku/"
seiga_directory="$HOME/gallery-dl/seiga/"
tumblr_directory="$HOME/gallery-dl/tumblr/"
twitter_directory="$HOME/gallery-dl/twitter/"
weibo_directory="$HOME/gallery-dl/weibo/"
yandere_directory="$HOME/gallery-dl/yandere/"


send_directory01="/vultr_picdir/"
send_directory02="/vultr_conffolder/"
ls_s3directory_report="$HOME/s3ls.log"
ls_localdirectory_report="$HOME/local_ls.log"
disk_area01=/
area_limit01=95
process_name=s3cmd

goofys --profile vultr --endpoint https://ewr1.vultrobjects.com picdir /vultr_picdir
goofys --profile vultr --endpoint https://ewr1.vultrobjects.com conffolder /vultr_conffolder

cd /vultr_picdir

while read line
do
    gallery-dl $line --download-archive $history
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

exit
