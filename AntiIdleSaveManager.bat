@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Anti-Idle Save Manager
color 79
:: Made by Evanito - https://github.com/Evanito/AntiIdleSaveManager

:: Hey there, inquisitive AntiIdler! You are looking at this code to see if it will make your computer explode. (It won't) I understand the curiosity, that's why this comment is here. 
:: Since Flash uses a string of random characters as a folder name to hide AntiIdle saves, the first step is to find that name.....

echo AntiIdle Backup and Restore tool
echo.
echo This batch file will backup or restore your progress on all local files of Anti-Idle: The Game.
echo Supports Google Chrome, Firefox, and Microsoft Edge running on Windows 7/10.
echo.

:documentsinit
echo Testing browsers for AntiIdle saves...
if exist %HOMEPATH%\Documents (
set documentsfolder=%HOMEPATH%\Documents
) else if exist "%HOMEPATH%\My Documents" (
set "documentsfolder=%HOMEPATH%\My Documents"
) else if exist "%HOMEPATH%\Mis Documentos" (
set "documentsfolder=%HOMEPATH%\Mis Documentos"
) else if exist "%HOMEPATH%\Desktop" (
echo Using Desktop fallback to backup!
set "documentsfolder=%HOMEPATH%\Desktop"
set desktopfallback=1
) else goto documentserror

:chromeinit
:: This command will go to where that folder is and assign it a variable name: "gctarget".
FOR /F "tokens=*" %%G IN ('dir /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects"') DO ( 
set gctarget=%%G
)
set "chromepath=%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%GCTARGET%\chat.kongregate.com"

:edgeinit
:: This command will go to where that folder is and assign it a variable name: "edgetarget".
FOR /F "tokens=*" %%E IN ('dir /B /AD "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects"') DO ( 
set edgetarget=%%E
)
set "edgepath=%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%EDGETARGET%\#AppContainer\chat.kongregate.com"

:firefoxinit
:: This command will go to where that folder is and assign it a variable name: "foxtarget". 
:: Though it is exactly the same as the EDGE init, I'll keep it for safe keeping.
FOR /F "tokens=*" %%F IN ('dir /B /AD "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects"') DO ( 
set foxtarget=%%F
)
set "foxpath=%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%FOXTARGET%\chat.kongregate.com"

:browsertest
:: Tests for MS Edge saves
if exist "%EDGEPATH%\antiIdle_file0.sol" (
set edgefound=true
echo Microsoft Edge saves found.
) else (
set edgedound=false
)
:: Tests for Chrome saves
if exist "%CHROMEPATH%\antiIdle_file0.sol" (
set chromefound=true
echo Google Chrome saves found.
) else (
set chromefound=false
)
:: Tests for Firefox saves
if exist "%FOXPATH%\antiIdle_file0.sol" (
set foxfound=true
echo Firefox saves found.
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

echo.
echo Checking for existing backups...
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup" ( 
echo Backups found, ready to restore. 
) else ( set restorewarning=[UNAVAILABLE]
echo No backups found.
)

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
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup" ( 
echo Main save folder found. 
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup" >nul 2>nul 
if '%chromefound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome" (
echo Chrome save folder found.
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome" >nul 2>nul 
)
if '%edgefound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge" (
echo Microsoft Edge save folder found.
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge" >nul 2>nul 
)
if '%foxfound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox" (
echo Firefox save folder found.
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox" >nul 2>nul 
)


:backup
:: Self explanatory.
if '%chromefound%'=='true' (
copy "%CHROMEPATH%\antiIdle_file0.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file0.sol" /Y
copy "%CHROMEPATH%\antiIdle_file1.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file1.sol" /Y
copy "%CHROMEPATH%\antiIdle_file2.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file2.sol" /Y
copy "%CHROMEPATH%\antiIdle_file3.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file3.sol" /Y
)
if '%foxfound%'=='true' (
copy "%FOXPATH%\antiIdle_file0.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file0.sol" /Y
copy "%FOXPATH%\antiIdle_file1.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file1.sol" /Y
copy "%FOXPATH%\antiIdle_file2.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file2.sol" /Y
copy "%FOXPATH%\antiIdle_file3.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file3.sol" /Y
)
if '%edgefound%'=='true' (
copy "%EDGEPATH%\antiIdle_file0.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file0.sol" /Y
copy "%EDGEPATH%\antiIdle_file1.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file1.sol" /Y
copy "%EDGEPATH%\antiIdle_file2.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file2.sol" /Y
copy "%EDGEPATH%\antiIdle_file3.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file3.sol" /Y
)
cls
echo Backups successful.
goto end

:restoreinit
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup" ( 
echo Main save folder found. 
) else goto nosavesrestore

:restore
:: This should make sense too.
if '%chromefound%'=='true' (
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file0" "%CHROMEPATH%\antiIdle_file0.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file1" "%CHROMEPATH%\antiIdle_file1.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file2" "%CHROMEPATH%\antiIdle_file3.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Google Chrome\antiIdle_file3" "%CHROMEPATH%\antiIdle_file4.sol" /Y
)
if '%foxfound%'=='true' (
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file0.sol" "%FOXPATH%\antiIdle_file0.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file1.sol" "%FOXPATH%\antiIdle_file1.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file2.sol" "%FOXPATH%\antiIdle_file2.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Firefox\antiIdle_file3.sol" "%FOXPATH%\antiIdle_file3.sol" /Y
)
if '%edgefound%'=='true' (
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file0.sol" "%EDGEPATH%\antiIdle_file0.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file1.sol" "%EDGEPATH%\antiIdle_file1.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file2.sol" "%EDGEPATH%\antiIdle_file2.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\Microsoft Edge\antiIdle_file3.sol" "%EDGEPATH%\antiIdle_file3.sol" /Y
)
cls
echo All saves restored.
goto end


:: And here are all the endings, they are alerts that either everything went well, or that something went wrong.
:end
echo.
echo Completed.
if '%desktopfallback%'=='1' (
echo Your saves are stored to your Desktop since they have nowhere else to go.
) else echo Your saves are kept in your Documents folder in a folder named:
echo "Anti-Idle backup" 
echo It is highly advised to keep this batch file in that folder as well,
echo to find it easily.
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

:documentserror
cls
echo UH OH! We couldn't find your documents folder! :(
echo It could be localization or an unsupported version of Windows (such as Vista)
echo.
echo Please open an issue on the GitHub repository (Link in README)
echo or email me at
echo yopu1234 at gmail dot com
echo.
echo.
echo If you want to continue anyway (And risk a new Documents folder appearing) Press any button.
echo Or, close this window to exit.
pause >nul
goto chromeinit