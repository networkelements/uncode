<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^% 
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%
pause & exit/b
: #>

# 変数は適宜修正
# winではscoopからだとgallery-dl.exeのある
# フォルダ("$env:userprofile\scoop\apps\gallery-dl\current")に
#「gallery-dl.conf」(https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.confをベースに修正)
# を置いてpixivなどのアカウント設定を
# 入れる必要あり(パスワードなどに特殊記号が入っているとparseできないので注意)

$dldirparent     = $env:userprofile + "\pictures\"
$dldir           = $dldirparent     + "gallery-dl\"
$dllist          = $env:userprofile + "\desktop\scripts\gallery-dl\dlurl.txt"


## https://scoop.sh/
## gallery-dlが初インストールの場合はコメントアウトを外す)
#Set-ExecutionPolicy RemoteSigned -scope CurrentUser
#scoop install gallery-dl


cd $dldirparent

# ダウンロード
$dluserlist = (get-content $dllist) -as [string[]]
$i=1
foreach ($dlurl in $dluserlist) {
    gallery-dl $dlurl
    $i++
}

