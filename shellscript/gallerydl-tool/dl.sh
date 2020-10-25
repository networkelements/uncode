url=`cat dlurlall.txt`
history="$HOME/gallery-dl-history.bin"

while read line
do
  gallery-dl $line --download-archive $history
done << FILE
$url    
FILE
