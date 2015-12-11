@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Anti-Idle Save Manager
color 79
:: Made by Evanito - https://github.com/Evanito/AntiIdleSaveManager

:: Hey there, inquisitive AntiIdler! You are looking at this code to see if it will make your computer explode. (It won't) I understand the curiosity, that's why this comment is here. 
:: Since Google Chrome uses a string of random characters as a folder name to hide AntiIdle saves, the first step is to find that name.....

echo AntiIdle Backup and Restore tool
echo.
echo This batch file will backup or restore your progress on all local files of Anti-Idle: The Game.
echo Supports Google Chrome, Firefox, and Microsoft Edge running on Windows 7/10.
echo.
echo Testing browsers for AntiIdle saves...



:chromeinit
:: This command will go to where that folder is and assign it a variable name: "gctarget".
FOR /F "tokens=*" %%G IN ('dir /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects"') DO ( 
set gctarget=%%G
)

:edgeinit
:: This command will go to where that folder is and assign it a variable name: "edgetarget".
FOR /F "tokens=*" %%G IN ('dir /B /AD "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects"') DO ( 
set edgetarget=%%G
)

:firefoxinit
:: This command will go to where that folder is and assign it a variable name: "foxtarget". 
:: Though it is exactly the same as the EDGE init, I'll keep it for safe keeping.
FOR /F "tokens=*" %%G IN ('dir /B /AD "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects"') DO ( 
set foxtarget=%%G
)

:browsertest
:: Tests for MS Edge saves
if exist "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file0.sol" (
set edgefound=true
echo Microsoft Edge saves found
) else (
set edgedound=false
)
:: Tests for Chrome saves
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file0.sol" (
set chromefound=true
echo Google Chrome saves found
) else (
set chromefound=false
)
:: Tests for Firefox saves
if exist "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file0.sol" (
set foxfound=true
echo Firefox saves found
) else (
set foxfound=false
)

if '%chromefound%'=='false' (
if '%edgefound%'=='false' (
if '%foxfound%'=='false' (
echo NO BROWSERS FOUND, BACKUP UNAVAILABLE
set backupwarning=[UNAVAILABLE]
)
)
)

REM if exist "%HOMEPATH%\My Documents\Anti-Idle backup" ( 
REM echo Backups found. 
REM ) else set restorewarning=[UNAVAILABLE]

echo.
echo This file will backup and/or restore ALL BROWSERS' SAVES AT ONCE. 
echo BE SURE THE GAME IS CLOSED WHEN RESTORING

:choice
echo.
echo ------------------------------------------
echo Choose one:
echo 1. Backup %BACKUPWARNING%
echo 2. Restore %RESTOREWARNING%
echo ------------------------------------------
echo.

set /p choice=Pick:
rem if not '%choice%'=='' set choice=%choice:~0;1%
if '%choice%'=='1' (
goto backupinit
)
if '%choice%'=='2' (
goto restore
)
if '%choice%'=='backup' (
goto backupinit
)
if '%choice%'=='restore' (
goto restoreinit
)



:backupinit
:: Double checks the saves exist in the first place.
if '%chromefound%'=='false' (
if '%edgefound%'=='false' (
if '%foxfound%'=='false' (
goto nosavesbackup
)
)
)

:: This makes the backup folder(s) for you if you don't have it already. I advise you keep this batch file within the main one.
if exist "%HOMEPATH%\My Documents\Anti-Idle backup" ( 
echo Main save folder found. 
) else MD "%HOMEPATH%\My Documents\Anti-Idle backup" >nul 2>nul 
if '%chromefound%'=='true' (
if exist "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome" (
echo Chrome save folder found.
) else MD "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome" >nul 2>nul 
)
if '%edgefound%'=='true' (
if exist "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge" (
echo Microsoft Edge save folder found.
) else MD "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge" >nul 2>nul 
)
if '%foxfound%'=='true' (
if exist "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox" (
echo Firefox save folder found.
) else MD "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox" >nul 2>nul 
)


:backup
:: Self explanatory.
if '%chromefound%'=='true' (
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file0.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file0.sol" /Y
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file1.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file1.sol" /Y
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file2.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file2.sol" /Y
copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file3.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file3.sol" /Y
)
if '%foxfound%'=='true' (
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file0.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file0.sol" /Y
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file1.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file1.sol" /Y
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file2.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file2.sol" /Y
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file3.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file3.sol" /Y
)
if '%edgefound%'=='true' (
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file0.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file0.sol" /Y
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file1.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file1.sol" /Y
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file2.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file2.sol" /Y
copy "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file3.sol" "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file3.sol" /Y
)
cls
echo Backups successful.
goto end

:restoreinit
if exist "%HOMEPATH%\My Documents\Anti-Idle backup" ( 
echo Main save folder found. 
) else goto nosavesrestore

:restore
:: This should make sense too.
if '%chromefound%'=='true' (
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file0" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file0.sol" /Y >nul
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file1" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file1.sol" /Y >nul
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file2" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file3.sol" /Y >nul
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Google Chrome\antiIdle_file3" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com\antiIdle_file4.sol" /Y >nul
)
if '%foxfound%'=='true' (
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file0.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file0.sol" /Y
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file1.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file1.sol" /Y
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file2.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file2.sol" /Y
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Firefox\antiIdle_file3.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com\antiIdle_file3.sol" /Y
)
if '%edgefound%'=='true' (
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file0.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file0.sol" /Y
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file1.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file1.sol" /Y
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file2.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file2.sol" /Y
copy "%HOMEPATH%\My Documents\Anti-Idle backup\Microsoft Edge\antiIdle_file3.sol" "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com\antiIdle_file3.sol" /Y
)
cls
echo All saves restored.
goto end


:end
echo.
echo Completed.
echo Your saves are kept in "Documents\Anti-Idle backup" 
echo It is advised to keep this batch file there as well.
echo.
echo Made by Evanito - https://github.com/Evanito/AntiIdleSaveManager
echo Press any key to exit.
pause >nul
exit

:nosavesbackup
cls
echo UH OH! You have no saves to back up! :(
echo Browsers supported: Chrome, MS Edge, and Firefox
echo If you have one of these browsers, yet your save was still not found, please email me at:
echo yopu1234 at gmail dot com
echo.
echo Press any key to exit.
pause >nul
exit

:nosavesrestore
cls
echo UH OH! You have no saves to restore! :(
echo Have you done a backup yet?
echo.
echo Can't fix your error? Email me at:
echo yopu1234 at gmail dot com
echo.
echo Press any key to exit.
pause >nul
exit
