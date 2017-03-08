;;--- Head --- Informations --- AHK ---

;;	Windows Media Center Fit Screen. Best fit for WMC without full screen. On monitor 1 or 2.
;;	Ajusted resolutions: 1366 x 768 1600 x 900  1680 x 1050  1920 x 1080
;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	Version 2017-03-08 - 2 screen supported.

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper (Var timer specified in WMC fitscreen.ini) sec start imediately

	SetEnv, title, WMC FitScreen
	SetEnv, mode, Fit Screen : HotKey F7
	SetEnv, version, Version 2017-03-08
	SetEnv, Author, LostByteSoft

	FileInstall, WMC fitscreen.ini, WMC fitscreen.ini, 0
	FileInstall, ico_loading.ico, ico_loading.ico, 0
	FileInstall, ico_running.ico, ico_running.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_wmc.ico, ico_wmc.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0

	IniRead, gotomon, WMC fitscreen.ini, options, gotomon
	IniRead, autorun, WMC fitscreen.ini, options, autorun
	IniRead, timer, WMC fitscreen.ini, options, timer
	IniRead, start, WMC fitscreen.ini, options, start
	IniRead, minimize, WMC fitscreen.ini, options, minimize
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen

	IfEqual, fullscreen , 1, SetEnv, fullscreenstart, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart,

;;--- Tray options ---

	Menu Tray, NoStandard
	Menu, tray, add, Exit, GuiClose						; GuiClose
	Menu Tray, Icon, Exit, ico_shut.ico
	Menu, tray, add, Refresh, doReload					; Reload the script.
	Menu Tray, Icon, Refresh, ico_reboot.ico, 1
	menu, tray, add
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox
	Menu Tray, Icon, Secret MsgBox, ico_lock.ico, 1
	Menu, tray, add, About - %Author%, about1				; Creates a new menu item.
	Menu, tray, add, Hotkey: F7, about5					; Show hotkey
	Menu Tray, Icon, Hotkey: F7, ico_wmc.ico, 1
	Menu, tray, add, Version - %version%, version				; About version
	menu, tray, add
	;Menu, tray, add, ++------, about4					; empty space
	Menu, tray, add, Autorun On/Off - %autorun%, autorunonoff		; autorun
	Menu, tray, add, Fullscreen On/Off - %fullscreen%, fullscreenonoff	; autorun
	;Menu, tray, add, +++-----, about2					; empty space
	Menu, tray, add, WMC Screen Choice - %gotomon%, screenselecttray	; select screen menu
	menu, tray, add
	Menu, tray, add, WMC Close, wmcclose					; Close or Exit WMC, useful when in nochrome mode
	Menu Tray, Icon, WMC Close, ico_shut.ico
	Menu, tray, add, WMC Full Screen, fullscreen				; Fullscreen
	menu, tray, add
	;Menu, tray, add, ++++----, about3					; empty space
	Menu, tray, add, Adjust / Start / F7, mousesend				; Run the script.
	Menu Tray, Icon, Adjust / Start / F7, ico_wmc.ico, 1

;;--- Software start here ---

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
	;;MsgBox, You screen is not supported. Goto Default values. It could be not best adjust.
	goto, Default

	;; WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]

768:
	IfEqual, gotomon ,2 , Goto, mon2-768
	WinMove, Windows Media Center, , 50, 0 , 1246
	WinActivate, Windows Media Center
	Goto, Run
	mon2-768:
	SysGet, Mon2, Monitor, 2
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	;;msgbox, Ecran 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%... gotomon=%gotomon% Mon2x=%mon2x%
	WinMove, Windows Media Center, , %Mon2Left%, 0 , 1246
	WinActivate, Windows Media Center
	Goto, Run

900:
	IfEqual, gotomon ,2 , Goto, mon2-900
	WinMove, Windows Media Center, , 60, 0 , 1480
	WinActivate, Windows Media Center
	Goto, Run
	mon2-900:
	SysGet, Mon2, Monitor, 2
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	;;msgbox, Ecran 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%... gotomon=%gotomon% Mon2x=%mon2x%
	WinMove, Windows Media Center, , %Mon2Left%, 0 , 1480
	WinActivate, Windows Media Center
	Goto, Run

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
	WinMove, Windows Media Center, , 0, 19 , 1680
	WinActivate, Windows Media Center
	Goto, Run
	mon2-1050:
	SysGet, Mon2, Monitor, 2
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	;;msgbox, Ecran 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%... gotomon=%gotomon% Mon2x=%mon2x%
	WinMove, Windows Media Center, , %Mon2Left%, 33 , 1680
	WinActivate, Windows Media Center
	Goto, Run

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
	WinMove, Windows Media Center, , 52, 0 , 1800
	WinActivate, Windows Media Center
	Goto, Run
	mon2-1080:
	SysGet, Mon2, Monitor, 2
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	;;msgbox, Ecran 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%... gotomon=%gotomon% Mon2x=%mon2x%
	WinMove, Windows Media Center, , %Mon2Left%, 19 , 1680
	WinActivate, Windows Media Center
	Goto, Run

Default:	;; Not the best fit. Screen 1 only.
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
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	IniRead, gotomon, WMC fitscreen.ini, options, gotomon
	IniRead, autorun, WMC fitscreen.ini, options, autorun
	IniRead, timer, WMC fitscreen.ini, options, timer
	IniRead, start, WMC fitscreen.ini, options, start
	IniRead, minimize, WMC fitscreen.ini, options, minimize
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen
	IfEqual, fullscreen , 1, SetEnv, fullscreenstart, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart, (disabled)
	MsgBox, title=%title% mode=%mode% version=%version% author=%author%`n`nt_UpTime=%t_UpTime% Hotkey=F7 A_WorkingDir=%A_WorkingDir%`n`nfullscreen=%fullscreen% start=%start% autorun=%autorun% timer=%timer% minimize=%minimize%`n`ngotomon=%gotomon% fullscreenstart=%fullscreenstart%`n`nresolution1=%Mon1Bottom% resolution2=%Mon2Bottom%
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen
	IfEqual, fullscreen , 1, SetEnv, fullscreenstart, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart,
	Menu, Tray, Icon, ico_running.ico
	Return

screenselecttray:
	Menu, Tray, Icon, ico_loading.ico
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	Loop, %MonitorCount%
	{
		SysGet, MonitorName, MonitorName, %A_Index%
		SysGet, Monitor, Monitor, %A_Index%
		SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	}
	select:
	InputBox, monitorselect , WMC Fitscreen, On witch monitor do you want to adjust WMC ? (2 monitor supported maximum) Actual monitor=%gotomon%`n`nMonitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
	IfGreater, monitorselect, %MonitorCount%, goto, select
		if ErrorLevel, goto, run
	IfEqual, monitorselect, 0, Goto, Select
	IniWrite, %monitorselect%, WMC fitscreen.ini, options, gotomon
	IfEqual, monitorselect, 1, SetEnv, gotomon, 1
	IfEqual, monitorselect, 2, SetEnv, gotomon, 2
	IfEqual, gotomon, 1, Menu, Tray, Rename, WMC Screen Choice - 2, WMC Screen Choice - 1
	IfEqual, gotomon, 2, Menu, Tray, Rename, WMC Screen Choice - 1, WMC Screen Choice - 2
	Menu, Tray, Icon, ico_running.ico
	goto, run

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
	Menu, Tray, Rename, Fullscreen On/Off - 0, Fullscreen On/Off - 1
	Menu, Tray, Icon, ico_running.ico
	Return
	disablefullscreen:
	IniWrite, 0, WMC fitscreen.ini, options, fullscreen
	SetEnv, fullscreen, 0
	TrayTip, %title%, fullscreen disabled - %fullscreen%, 2, 2
	Menu, Tray, Rename, Fullscreen On/Off - 1, Fullscreen On/Off - 0
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
	Menu, Tray, Rename, Autorun On/Off - 0, Autorun On/Off - 1
	Menu, Tray, Icon, ico_running.ico
	Return
	disableautorun:
	IniWrite, 0, WMC fitscreen.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off - 1, Autorun On/Off - 0
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
about4:
about5:
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
	sleep, 500
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
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;		encounters with beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;;--- End of file ---