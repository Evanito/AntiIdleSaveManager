@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title A-I Backup and Restore
color 79
:: Made by Evanito - https://steamcommunity.com/id/Evanito/

:: Hey there, inquisitive AntiIdler! You are looking at this code to see if it will make your computer explode. (It won't) I understand the curiosity, that's why this comment is here. 
:: Since Google Chrome uses a string of random characters as a folder name to hide AntiIdle saves, the first step is to find that name.....

echo AntiIdle Backup and Restore tool
echo -
echo This batch file will backup or restore your progress on all local files of Anti-Idle: The Game.
echo Only tested with Google Chrome running on Windows 7/10.

:: This little command will go to where that folder is and assign it a variable name: "target". Yes, I know I could have picked a less menacing name, but it does its job.
FOR /F "tokens=*" %%G IN ('dir /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects"') DO ( 
set target=%%G
)


:choice
echo -
echo ------------------------------------------
echo Choose one:
echo 1. Backup
echo 2. Restore
echo ------------------------------------------
echo -

set /p choice=Pick:
rem if not '%choice%'=='' set choice=%choice:~0;1%
if '%choice%'=='1' goto backup
if '%choice%'=='2' goto restore
if '%choice%'=='backup' goto backup
if '%choice%'=='restore' goto restore



:backup
:: This makes the backup folder for you if you don't have it already. I advise you keep this batch file within.
if exist "%HOMEPATH%\My Documents\Anti-Idle backup" ( 
goto backup1 )else MD "%HOMEPATH%\My Documents\Anti-Idle backup" >nul 2>nul 


:backup1
:: Self explanatory.
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file0.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file0.sol" /Y
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file1.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file1.sol" /Y
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file3.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file2.sol" /Y
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file4.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file3.sol" /Y
cls
echo The backups are now in your Documents folder.
goto end


:restore
:: This too.
copy "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file0" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file0.sol" /Y >nul
copy "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file1" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file1.sol" /Y >nul
copy "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file2" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file3.sol" /Y >nul
copy "%HOMEPATH%\My Documents\Anti-Idle backup\antiIdle_file3" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%TARGET%\chat.kongregate.com\antiIdle_file4.sol" /Y >nul
cls
echo All saves restored.
goto end


:end
echo -
echo Completed.
echo Your saves are kept in "Documents\Anti-Idle backup" 
echo It is advised to keep this batch file there as well.
echo -
echo Made by Evanito - https://steamcommunity.com/id/Evanito/
echo Press any key to exit.
pause >nul
exit

