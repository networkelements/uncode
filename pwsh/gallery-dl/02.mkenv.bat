<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^% 
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%
pause & exit/b
: #>

###  * 2021年3月7日 変わった模様？
###  # winではscoopからだとgallery-dl.exeのある
###  # フォルダ("$env:userprofile\scoop\apps\gallery-dl\current")に
#「gallery-dl.conf」(https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.confをベースに修正)
# を置いてpixivなどのアカウント設定を
# 入れる必要あり(パスワードなどに特殊記号が入っているとparseできないので注意)


# $galery-dl-confurl = https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.conf


$galery_dl_confpath = "$env:userprofile\.config\gallery-dl\"
$galery_dl_conf     = "config.json"
$local_save_dir     = $env:userprofile + "\desktop\gallery-dl\"
$tooldir            = $local_save_dir + "!01.dltool"

mkdir $local_save_dir
mkdir $tooldir
mkdir $galery_dl_confpath

read-host    "01.install.gallery-dl.batでconfig.jsonを格納(上書き)したら、Enterを押下してください"


cp .\$galery_dl_conf $galery_dl_confpath


ls $tooldir
cd $tooldir

git clone https://github.com/networkelements/uncode.git
cd uncode
git remote add upstream https://github.com/networkelements/uncode.git
git branch -a

