<# :
@echo off & setlocal
set BATCH_ARGS=%*
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:"=\"%
if defined BATCH_ARGS set BATCH_ARGS=%BATCH_ARGS:^^=^% 
endlocal & Powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "$input|&([ScriptBlock]::Create((${%~f0}|Out-String)))" %BATCH_ARGS%
pause & exit/b
: #>

# win�ł�scoop���炾��gallery-dl.exe�̂���
# �t�H���_("$env:userprofile\scoop\apps\gallery-dl\current")��
#�ugallery-dl.conf�v(https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.conf���x�[�X�ɏC��)
# ��u����pixiv�Ȃǂ̃A�J�E���g�ݒ��
# �����K�v����(�p�X���[�h�Ȃǂɓ���L���������Ă����parse�ł��Ȃ��̂Œ���)


# $galery-dl-confurl = https://raw.githubusercontent.com/mikf/gallery-dl/master/docs/gallery-dl.conf


$galery_dl_binpath = "$env:userprofile\scoop\apps\gallery-dl\current\"
$galery_dl_conf    = gallery-dl.conf
$local_save_dir    = $env:userprofile + "\desktop\gallery-dl\"
$tooldir           = $local_save_dir + "!01.dltool"

mkdir $local_save_dir
mkdir $tooldir


read-host    "01.install.gallery-dl.bat��config.json���i�[(�㏑��)������AEnter���������Ă�������"


cp .\$galery_dl_conf $galery_dl_binpath


ls $tooldir
cd $tooldir

git clone https://github.com/networkelements/uncode.git
cd uncode
git remote add upstream https://github.com/networkelements/uncode.git
git branch -a

