# AntiIdle Save Manager

Creator: Evanito (Evan Gierst) yopu1234 at gmail dot com

Compatability: Supports Google Chrome, Firefox, and Microsoft Edge on Windows 7 and 10

Game: *Anti-Idle: The Game* by Tukkun - http://www.kongregate.com/games/Tukkun/anti-idle-the-game

Repository: https://github.com/Evanito/AntiIdleSaveManager

------

## About:
This batch file primarily is used to easily backup and restore your Anti-Idle save files. It keeps them safe in your documents folder, and requires no configuration or computer knowledge to use. It supports Google Chrome, Microsoft Edge, and Mozilla Firefox, with autodetection of which browser you use.
I will update the file through GitHub if I wish to add a new feature or if AntiIdle changes its save mechanics.
You can see what features I have planned by visiting the GitHub wiki page: https://github.com/Evanito/AntiIdleSaveManager/wiki/Possible-Future-Features

The batch file is commented if you want to investigate the code with a simple explanation. I *recommend* reading it, in fact.

It is as simple to use as just run, select “backup” and play with peace of mind that your saves are safe. 
If at any time you need to restore, it does that just as easily. (Just remember to close the game before restoring, or else the saves will be lost.)

It also doesn’t install anything on your computer, it only makes a folder in your documents folder to house the backups. 
It is also recommended to store the batch file there.

Pull requests through GitHub are encouraged if you wish to help expand its features.

-------

## Credits to Kongregate users:
* Uroogla (For info on Microsoft Edge save location)
* carlos198 (For bringing to my attention the chance that a documents folder may not be where I think it is)

-------

## Usage Tutorial:

1) Download the .zip file from the link above and save it anywhere.

2) Unzip the .zip and read the README.md if you want.

3) Run the AntiIdleSaveManager.bat file.

It checks your computer for any saves it can find, and will tell you which browser it found them in. It shows Google Chrome for me since I use Google Chrome, but it also supports Firefox and MS Edge. Since I have also used the tool before, it found my backups and is ready to restore them.
The first time you run this, it will likely tell you the restore option is unavailable since you haven’t backed up yet.

4) Select whether you wish to Backup your current saves or Restore previous backups.

5a) If backing up, simply type “1” or “backup” then hit enter. Your saves in all browsers will be backed up to your Documents folder, in a folder called “Anti-Idle backup”.

5b) If restoring, first make sure the game is not running in any open browsers.

That is very important.

Then type “2” or “restore” and hit enter, your backups will move the location of their respective browser’s Anti-Idle saves.

Note: If your browser saves are deleted accidentally and you need to restore, run the game once to generate blank saves so the script can detect your browser, otherwise you will get an error. (Do not back up the blank saves.)

6) Rest easy :-)

7) (Optional) Check back to the downloads link occasionally, as this project is updated often (as of 12/12/15).

Disclaimer: Batch files can be used for evil. Don’t trust just anyone on the internet offering you a batch file to run. Your computer will likely give you this same warning and it is your job to trust what you are running. I personally check every line of code that goes into my script and never allow anything that would be considered malicious. I do this project to help the community, not take advantage of it. That said, be careful.
