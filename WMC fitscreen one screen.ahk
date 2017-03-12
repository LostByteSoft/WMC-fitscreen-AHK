;;--- Head --- AHK ---
;; Windows Media Center Fit Screen. Best fit for WMC without full screen. On monitor 1.
;; Ajusted resolutions: 1366 x 768 1600 x 900  1680 x 1050  1920 x 1080
;; Compatibility: Windows
;; All files must be in same folder. Where you want.
;; 64 bit AHK version : 1.1.24.2 64 bit Unicode

	SetEnv, title, WMC FitScreen (One Screen)
	SetEnv, mode, Fit Screen : HotKey F7
	SetEnv, version, Version 2017-03-12
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	#SingleInstance Force
	#Persistent
	SetWorkingDir, %A_ScriptDir%
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper 45 sec start imediately
	IfExist, WMC fitscreen.ini, Goto, check
	SetEnv, autorun, 1
	SetEnv, timer, 120
	SetEnv, minimize, 0
	SetEnv, start, /playallmusic /widescreen
	check:
	FileInstall, WMC fitscreen.ini, WMC fitscreen.ini, 0
	FileInstall, ico_loading.ico, ico_loading.ico, 0
	FileInstall, ico_running.ico, ico_running.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_wmc.ico, ico_wmc.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_full.ico, ico_full.ico, 0
	FileInstall, ico_monitor.ico, ico_monitor.ico, 0
	FileInstall, ico_green.ico, ico_green.ico, 0
	FileInstall, ico_minimize.ico, ico_minimize.ico, 0
	FileInstall, ico_maximize.ico, ico_maximize.ico, 0

	IniRead, gotomon, WMC fitscreen.ini, options, gotomon
	IniRead, autorun, WMC fitscreen.ini, options, autorun
	IniRead, timer, WMC fitscreen.ini, options, timer
	IniRead, start, WMC fitscreen.ini, options, start
	IniRead, minimize, WMC fitscreen.ini, options, minimize
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen

;;--- Menu Tray options

	Menu, tray, add, Refresh, doReload			; Reload the script.
	Menu, tray, add, --------, secret			; Secret MsgBox
	Menu, tray, add, About, about1				; Creates a new menu item.
	Menu, tray, add, Version, version			; About version
	Menu, tray, add, Autorun On/Off, autorunonoff		; autorun
	Menu, tray, add, Fullscreen On/Off, fullscreenonoff	; autorun
	Menu, tray, add, +-------, about2			; empty space
	Menu, tray, add, WMC Close, wmcclose			; Close or Exit WMC, useful when in nochrome mode
	Menu, tray, add, WMC Full Screen, fullscreen		; Fullscreen
	Menu, tray, add, ++------, about3			; empty space
	Menu, tray, add, Adjust / Start / F7, mousesend		; Run the script.

;;--- Software start here ---

	IfEqual, fullscreen , 1, SetEnv, fullscreenstart, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart,

	IfWinExist, Windows Media Center,, goto, move
	goto, start
start:
	Menu, Tray, Icon, ico_loading.ico
	IfExist, %windir%\ehome\ehshell.exe				;; check if WMC is installed
		{	IfEqual, autorun , 0, goto, run
			IfGreater, t_UpTime, %timer%, goto, skip	;; Elapsed seconds since start if uptime upper variable timer sec start imediately
			sleep, %timer%000

			skip:
			Menu, Tray, Icon, ico_loading.ico
			run, "%windir%\ehome\ehshell.exe" %start%
			sleep, 500
			WinWait, Windows Media Center
			IfEqual, minimize, 1, goto, minimize
			goto, move
		}
	else
		{	Menu, Tray, Icon, ico_running.ico
			MsgBox, WMC not installed.
			goto, GuiClose
		}

run:
	Menu, Tray, Icon, ico_running.ico
	KeyWait, F7, D
	Menu, Tray, Icon, ico_loading.ico
	IfWinExist, Windows Media Center,, goto, move
	run, "%windir%\ehome\ehshell.exe" %start% %fullscreenstart%
	sleep, 500
	WinWait, Windows Media Center
	sleep, 500
	WinActivate, Windows Media Center

move:
	Menu, Tray, Icon, ico_loading.ico
	sleep, 500
	SetEnv, Mon1Bottom,
	SysGet, Mon1, Monitor, 1
	IfEqual, Mon1Bottom , 768, goto, 768
	IfEqual, Mon1Bottom , 900, goto, 900
	IfEqual, Mon1Bottom , 1050, goto, 1050
	IfEqual, Mon1Bottom , 1080, goto, 1080
	;;MsgBox, You screen is not supported. Goto Default
	goto, Default

768:
	WinMove, Windows Media Center, , 50, 0 , 1246
	WinActivate, Windows Media Center
	Goto, Run

900:
	WinMove, Windows Media Center, , 60, 0 , 1480
	WinActivate, Windows Media Center
	Goto, Run

1050:
	WinMove, Windows Media Center, , 0, 19 , 1680
	WinActivate, Windows Media Center
	Goto, Run

1080:
	WinMove, Windows Media Center, , 52, 0 , 1800
	WinActivate, Windows Media Center
	Goto, Run

Default:	;; Not the best fit.
	;;MsgBox, Ecran 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%... Default
	SetEnv, Var1, %Mon1Right%
	SetEnv, Var2, 100
	var1 -= var2
	SetEnv, Var3, %Mon1Bottom%
	SetEnv, Var4, 100			;; -40 win bar +-20 i don't know why
	var3 -= var4
	;;Msgbox x25 y25 w%Var1% h%Var3% Visual NEW position (ESC exit) (OK continue)
	sleep, 500
	WinMove, Windows Media Center, , 0, 0 , %Var1%, %Var3%
	WinActivate, Windows Media Center
	Goto, Run

minimize:
	WinMinimize, Windows Media Center
	goto, run

;;--- Quit (escape , esc) ---

GuiClose:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, ico_loading.ico
	MsgBox, start=%start% autorun=%autorun% timer=%timer% minimize=%minimize% version=%version% resolution=%Mon1Bottom% t_UpTime=%t_UpTime% Hotkey=F7 A_WorkingDir=%A_WorkingDir% fullscreen=%fullscreen%
	Menu, Tray, Icon, ico_running.ico
	Return

screenselecttray:
	Goto, screenchoice

fullscreenonoff:
	Menu, Tray, Icon, ico_loading.ico
	IfEqual, fullscreen, 1, goto, disablefullscreen
	IfEqual, fullscreen, 0, goto, enablefullscreen
	msgbox, error_04 fullscreen error fullscreen=%fullscreen%
	Menu, Tray, Icon, ico_running.ico
	Return

	enablefullscreen:
	IniWrite, 1, WMC fitscreen.ini, options, fullscreen
	SetEnv, fullscreen, 1
	TrayTip, %title%, fullscreen enabled - %fullscreen%, 2, 2
	Menu, Tray, Icon, ico_running.ico
	Return

	disablefullscreen:
	IniWrite, 0, WMC fitscreen.ini, options, fullscreen
	SetEnv, fullscreen, 0
	TrayTip, %title%, fullscreen disabled - %fullscreen%, 2, 2
	Menu, Tray, Icon, ico_running.ico
	Return

autorunonoff:
	Menu, Tray, Icon, ico_loading.ico
	IfEqual, autorun, 1, goto, disableautorun
	IfEqual, autorun, 0, goto, enableautorun
	msgbox, error_03 sound error
	Menu, Tray, Icon, ico_running.ico
	Return

	enableautorun:
	IniWrite, 1, WMC fitscreen.ini, options, autorun
	SetEnv, autorun, 1
	TrayTip, %title%, Autorun enabled - %autorun%, 2, 2
	Menu, Tray, Icon, ico_running.ico
	Return

	disableautorun:
	IniWrite, 0, WMC fitscreen.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Icon, ico_running.ico
	Return

mousesend:
	Menu, Tray, Icon, ico_loading.ico
	run, "%windir%\ehome\ehshell.exe" %start% %fullscreenstart%
	sleep, 500
	WinWait, Windows Media Center
	goto, move

wmcclose:
	Menu, Tray, Icon, ico_loading.ico
	sleep, 1000
	WinClose, Windows Media Center
	goto, run

about1:
about2:
about3:
	Menu, Tray, Icon, ico_loading.ico
	TrayTip, %title%, %mode% by %author%, 2, 1
	Menu, Tray, Icon, ico_running.ico
	Return

version:
	Menu, Tray, Icon, ico_loading.ico
	TrayTip, %title%, %version%, 2, 2
	Menu, Tray, Icon, ico_running.ico
	Return

doReload:
	Menu, Tray, Icon, ico_loading.ico
	Reload
	Menu, Tray, Icon, ico_running.ico
	Return

fullscreen:
	Menu, Tray, Icon, ico_loading.ico
	WinActivate, Windows Media Center
	sleep, 500
	send, !{enter}
	Menu, Tray, Icon, ico_running.ico
	Return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---