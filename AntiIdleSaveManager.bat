@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Anti-Idle Save Manager v2.0.0
color 79
:: Made by Evanito - https://github.com/Evanito/AntiIdleSaveManager

:: Hey there, inquisitive AntiIdler! You are looking at this code to see if it will make your computer explode. (It won't) I understand the curiosity, that's why this comment is here. 
:: Since Flash uses a string of random characters as a folder name to hide AntiIdle saves, the first step is to find that name.....

echo AntiIdle Backup and Restore tool
echo.
echo This batch file will backup or restore your progress on all local files of Anti-Idle: The Game.
echo Supports browsers using Pepper or Adobe Flash (Google Chrome, Firefox, Microsoft Edge, etc.) running on Windows 7/10.
echo.

:documentsinit
echo Testing browsers for AntiIdle saves...
if exist "%HOMEPATH%\Documents" (
set "documentsfolder=%HOMEPATH%\Documents"
) else if exist "%HOMEPATH%\My Documents" (
set "documentsfolder=%HOMEPATH%\My Documents"
) else if exist "%HOMEPATH%\Mis Documentos" (
set "documentsfolder=%HOMEPATH%\Mis Documentos"
) else if exist "%HOMEPATH%\Desktop" (
echo Using Desktop fallback to backup!
set "documentsfolder=%HOMEPATH%\Desktop"
set desktopfallback=true
) else ( 
set "documentsfolder=/"
set nodesktop=true
goto documentserror
)

:init
:: Some startup tests
if not defined nodesktop goto pepperinit
if %NODESKTOP%==true (
echo Running without Documents folder...
echo.
)
:: Gets mydate, for backup labeling.
for /f "skip=1" %%x in ('wmic os get localmydatetime') do if not defined mydate set mydate=%%x
echo %MYDATE%

:pepperinit
:: This command will go to where that folder is and assign it a variable name: "pptarget".
FOR /F "tokens=*" %%G IN ('dir /B /AD "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects"') DO ( 
set pptarget=%%G
)
set "pepperpath=%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects\%PPTARGET%\chat.kongregate.com"

:adobeinit
:: This command will go to where that folder is and assign it a variable name: "adobetarget".
FOR /F "tokens=*" %%E IN ('dir /B /AD "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects"') DO ( 
set adobetarget=%%E
)
set "adobepath=%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\%ADOBETARGET%\#AppContainer\chat.kongregate.com"


:browsertest
:: Tests for AdobeFlash saves
if exist "%ADOBEPATH%\antiIdle_file*.sol" (
set adobefound=true
echo Adobe Flash saves found.
) else (
set adobefound=false
)
:: Tests for PepperFlash (Chrome) saves
if exist "%PEPPERPATH%\antiIdle_file*.sol" (
set pepperfound=true
echo Pepper Flash saves found.
) else (
set pepperfound=false
)


if '%pepperfound%'=='false' (
if '%adobefound%'=='false' (
echo NO BROWSERS FOUND, BACKUP UNAVAILABLE
set backupwarning=[UNAVAILABLE]
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
echo B - Backup %BACKUPWARNING%
echo R - Restore %RESTOREWARNING%
echo ------------------------------------------
echo Will default to Backup after 30 seconds.
echo.

choice /c BR /t 30 /d B
if "%ERRORLEVEL%"=="1" goto backupinit
if "%ERRORLEVEL%"=="2" goto restoreinit
pause >nul


:backupinit
:: Double checks the saves exist in the first place.
if '%pepperfound%'=='false' (
if '%adobefound%'=='false' (
goto nosavesbackup
)
)

:: This makes the backup folder(s) for you if you don't have it already. I advise you keep this batch file within the main one.
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup" ( 
echo Main save folder found. 
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup" >nul 2>nul 
if '%pepperfound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)" (
echo Chrome save folder found.
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)" >nul 2>nul 
)
if '%adobefound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)" (
echo Microsoft Edge save folder found.
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)" >nul 2>nul 
)

:: Makes a copy of the Save Manager alongside the Backups
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\AntiIdleSaveManager.bat" (
echo.
) else (
echo Batch missing
copy AntiIdleSaveManager.bat "%DOCUMENTSFOLDER%\Anti-Idle backup\" /Y
)
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\README.md" (
echo.
) else (
echo Readme missing
copy README.md "%DOCUMENTSFOLDER%\Anti-Idle backup\" /Y
)
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\LICENSE.txt" (
echo.
) else (
echo License missing
copy LICENSE.txt "%DOCUMENTSFOLDER%\Anti-Idle backup\" /Y
)



:backup
:: Backups game saves to Documents
if '%pepperfound%'=='true' (
copy "%PEPPERPATH%\antiIdle_file*.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\antiIdle_file*.sol" /Y
copy "%PEPPERPATH%\ATG_Global.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\ATG_Global.sol" /Y
)
if '%adobefound%'=='true' (
copy "%ADOBEPATH%\antiIdle_file*.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\antiIdle_file*.sol" /Y
copy "%ADOBEPATH%\ATG_Global.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\ATG_Global.sol" /Y
)
cls
echo Backups successful.
goto end

:restoreinit
:: Makes sure everything is set for restoring.
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup" ( 
echo Main save folder found. 
) else goto nosavesrestore
cls
echo HEY, You better have your game closed or else restoring may have no effect.
echo.
echo You better have your game closed or else restoring may have no effect.
echo.
echo You better have your game closed or else restoring may have no effect.
echo.
echo I am not responsible for overwritten saves.
echo.
echo Press any key if you understand and wish to continue.
pause >nul

:restore
:: Restores files from Documents.

:: Makes an emergency backup, in case you accidentally overwrite something you didn't mean to.
if '%pepperfound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\Restore Backups" ( 
echo Restore backups folder found. 
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\Restore Backups" >nul 2>nul 
copy "%PEPPERPATH%\antiIdle_file*.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\Restore Backups\antiIdle_file*%mydate%.sol" /Y
copy "%PEPPERPATH%\ATG_Global.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\Restore Backups\ATG_Global%mydate%.sol" /Y
:: Restoring...
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\antiIdle_file*" "%PEPPERPATH%\antiIdle_file*.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\PepperFlash (Chrome)\ATG_Global.sol" "%PEPPERPATH%\ATG_Global.sol" /Y
)

if '%adobefound%'=='true' (
if exist "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\Restore Backups" ( 
echo Restore backups folder found. 
) else MD "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\Restore Backups" >nul 2>nul 
copy "%ADOBEPATH%\antiIdle_file*.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\Restore Backups\antiIdle_file*%mydate%.sol" /Y
copy "%ADOBEPATH%\ATG_Global.sol" "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\Restore Backups\ATG_Global%mydate%.sol" /Y
:: Restoring...
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\antiIdle_file*.sol" "%ADOBEPATH%\antiIdle_file*.sol" /Y
copy "%DOCUMENTSFOLDER%\Anti-Idle backup\AdobeFlash (Edge, Firefox)\ATG_Global.sol" "%ADOBEPATH%\ATG_Global.sol" /Y
)
cls
echo All saves restored.
echo Backups of your active saves before restore can be found in the Restore Backups folder.
goto end


:: And here are all the endings, they are alerts that either everything went well, or that something went wrong.
:end
echo.
echo Completed.
if '%DESKTOPFALLBACK%'=='true' (
echo Your saves are stored to your Desktop since they have nowhere else to go.
) else ( 
echo Your saves are kept in your Documents folder in a folder named:
echo "Anti-Idle backup" 
)
echo It is highly advised to keep this batch file in that folder as well,
echo to find them easily.
echo.
echo Made by Evanito - https://github.com/Evanito/AntiIdleSaveManager
echo.
echo Press any key to exit, or exit in 30 seconds.
timeout /t 30
exit

:nosavesbackup
cls
echo UH OH! You have no saves to back up! :(
echo Browsers 100% supported: Chrome, MS Edge, and Firefox
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
goto init