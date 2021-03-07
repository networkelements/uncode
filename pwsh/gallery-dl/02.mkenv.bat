<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^% 
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%
pause & exit/b
: #>

# winではscoopからだとgallery-dl.exeのある
# フォルダ("$env:userprofile\scoop\apps\gallery-dl\current")に
#「gallery-dl.conf」(https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.confをベースに修正)
# を置いてpixivなどのアカウント設定を
# 入れる必要あり(パスワードなどに特殊記号が入っているとparseできないので注意)


# $galery-dl-confurl = https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.conf


$galery-dl-binpath = "$env:userprofile\scoop\apps\gallery-dl\current\"
$galery-dl-conf    = gallery-dl.conf
$local-save-dir    = $env:userprofile + "\desktop\gallery-dl\"
$tooldir           = $local-save-dir + "!01.dltool"

mkdir $local-save-dir
mkdir $tooldir


read-host    "config.jsonを格納したら、Enterを押下してください"
write-output "config.json内を置換します"


get-content $galery-dl-conf                               |
 % { $_ -replace "base-directory`"`: `".*",               `
                 "base-directory`"`: `"$local-save-dir" }

cp .\$galery-dl-conf galery-dl-binpath


ls $tooldir
cd $tooldir

git clone https://github.com/networkelements/uncode.git
cd uncode
git remote add upstream https://github.com/networkelements/uncode.git
git branch -a

