<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^% 
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%
pause & exit/b
: #>

$local_save_dir    = $env:userprofile + "\desktop\gallery-dl\"
$tooldir           = $local_save_dir + "!01.dltool\uncode"

ls $tooldir
cd $tooldir ; git fetch upstream ; git checkout master ; git merge upstream/master ; cd $env:userprofile

$dllist          = $tooldir  + "\shellscript\gallerydl-tool\dlurlall.txt"

$dluserlist = (get-content $dllist) -as [string[]]
$i=1
foreach ($dlurl in $dluserlist) {
    gallery-dl $dlurl
    $i++
}


