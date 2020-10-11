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
$pixivdir        = $dldir           + "pixiv\"
$twitterdir      = $dldir           + "twitter\"

# gallery-dlの更新
scoop update gallery-dl

# 既にdlしたフォルダ名からユーザ一覧を作成する
ls $pixivdir   | select -expandproperty name | set-variable pixivdllist01
ls $twitterdir | select -expandproperty name | set-variable twitterdllist


cd $dldirparent


# pixiv更新
$pixivdllist01 -replace "\D+",$null | set-variable pixivdllist02
echo $pixivdllist02
$pxuserlist = (echo $pixivdllist02) -as [string[]]
$i=1
foreach ($pxusername in $pxuserlist) {
    $pxdlurl = "https://www.pixiv.net/users/" + $pxusername
    echo $pxdlurl
    gallery-dl $pxdlurl
    $i++
}





# twitter更新
$twuserlist = (echo $twitterdllist) -as [string[]]
$i=1
foreach ($twusername in $twuserlist) {
    $twdlurl = "https://twitter.com/" + $twusername
    gallery-dl $twdlurl
    $i++
}

