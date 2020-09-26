<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^%
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%

pause & exit/b
: #>

# 古いアプリバージョンを消したくない場合はscoop cleanup箇所を消す
scoop update * ; scoop cleanup *


# scoop appsフォルダをスキャンしてリザルトを返す
$appsdir = $env:USERPROFILE + "\scoop\apps"
Start-MpScan -ScanType CustomScan -ScanPath $appsdir


Get-MpThreat | fl
