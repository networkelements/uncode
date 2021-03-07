<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^% 
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%
pause & exit/b
: #>

iwr -useb get.scoop.sh | iex
scoop install git

scoop bucket add extras
scoop bucket add iyokan-jp https://github.com/tetradice/scoop-iyokan-jp

scoop install gallery-dl


write-output "æ‚Ù‚Ç‚¨“n‚µ‚µ‚½config.json‚ğ"
write-output "02.mkenv.bat‚Æ“¯‚¶ƒtƒHƒ‹ƒ_‚ÉŠi”[‚µ‚Ä‚­‚¾‚³‚¢"

