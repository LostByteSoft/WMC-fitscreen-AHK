@echo Version 2017-09-16-1039
@echo ----------------------------------------------------------
cd "%~dp0"
taskkill /f /im "WMC fitscreen.exe"
taskkill /f /im "wmc_monitor1.exe"
taskkill /f /im "wmc_monitor2.exe"
taskkill /f /im "wmc_monitor3.exe"
@echo ----------------------------------------------------------
copy "*.exe" "C:\Program Files\"
copy "*.ini" "C:\Program Files\"
copy "icons\*.ico" "C:\Program Files\"
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\WMC" goto copy
md "%appdata%\Microsoft\Windows\Start Menu\Programs\WMC"
:copy
copy "lnk\*.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\WMC\"
copy "lnk\WMC fitscreen.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
@echo copy "lnk\WMC fitscreen.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\"
@echo ----------------------------------------------------------

@echo Copy an *.ini file is not necessary, an default ini is copied.

:start
@ECHO.
@ECHO 1. Print Asus 1
@ECHO 2. Print Master 2
@ECHO 3. Print Multi 3
@ECHO 4. print Server 4
@set choice=
@set /p choice=Type the number to print text.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto asus
if '%choice%'=='2' goto master
if '%choice%'=='3' goto multi
if '%choice%'=='4' goto server
@ECHO "%choice%" is not valid, try again
@ECHO.
goto start

:asus
del "C:\Program Files\WMC fitscreen.ini"
copy "asus\*.ini" "C:\Program Files\"
goto exit

:master
del "C:\Program Files\WMC fitscreen.ini"
copy "master\*.ini" "C:\Program Files\"
goto exit

:multi
del "C:\Program Files\WMC fitscreen.ini"
copy "multi\*.ini" "C:\Program Files\"
goto exit

:server
del "C:\Program Files\WMC fitscreen.ini"
copy "server\*.ini" "C:\Program Files\"
goto exit

:exit
@echo You can close this windows
@"C:\Program Files\WMC fitscreen.exe"
@echo ----------------------------------------------------------
@exit