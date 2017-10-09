;;--- Head --- Informations --- AHK ---

;;	File name: wmc_monitor3.exe

;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Variables ---

	SetEnv, title, WMC F4 move to monitor 3
	SetEnv, mode, Fit Screen : HotKey F4
	SetEnv, version, Version 2017-10-09-1913
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv

	FileInstall, icons\ico_HotKeys.ico, ico_HotKeys.ico, 0
	FileInstall, icons\ico_shut.ico, ico_shut.ico, 0
	FileInstall, icons\ico_3.ico, ico_3.ico, 0

	Menu, Tray, NoStandard
	Menu, tray, add, Exit, GuiClose2
	Menu, Tray, Icon, Exit, ico_shut.ico
	Menu, tray, add, Deactivate HotKey, Deactivate
	Menu, Tray, Icon, Deactivate HotKey, ico_3.ico
	Menu, tray, add, Hotkey: F4 Monitor 3, run2
	Menu, Tray, Icon, Hotkey: F4 Monitor 3, ico_HotKeys.ico
	Menu, Tray, Tip, %title%

;;--- Software start here ---

run:
	Menu, Tray, Icon, ico_3.ico
	KeyWait, F4, D
	run2:
	IniRead, pausekey, WMC fitscreen.ini, options, pausekey
	IfEqual, pausekey, 1, Goto, inpause
	SysGet, MonitorCount, MonitorCount
	IfEqual, MonitorCOunt, 1, goto, onlyonemonitor
	IfEqual, MonitorCOunt, 2, goto, onlyonemonitor
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	SysGet, Mon3, Monitor, 3
	SetEnv, gotomon, 3
	IniWrite, 3, WMC fitscreen.ini, options, gotomon
	IfWinExist, Windows Media Center,, goto, move
	Goto, Run

inpause:
	sleep, 2000
	Goto, run

onlyonemonitor:
	MsgBox, 0, WMC FitScreen, You only have one monitor. You could not change this setting. %title% %mode% (Time out 10 sec.). This msg is just information, it will not disable this shortcut., 10
	Goto, inpause

Deactivate:
	IniWrite, 0, WMC fitscreen.ini, options, hotkeyf4
	Goto, ExitApp

move:
	Menu, Tray, Icon, ico_yellow.ico
	IniRead, gotomon, WMC fitscreen.ini, options, gotomon
	IfEqual, Mon1Bottom , 768, goto, 768
	IfEqual, Mon1Bottom , 900, goto, 900
	IfEqual, Mon1Bottom , 1050, goto, 1050
	IfEqual, Mon1Bottom , 1080, goto, 1080
	;MsgBox, You screen is not supported. Goto Default values. It could be not best adjust. (Fail to detect resolution)
	goto, Default

768:
	IfEqual, gotomon, 2, Goto, mon2-768
	IfEqual, gotomon, 3, Goto, mon3-768
	SetEnv, Mon1Left1, %Mon1Left%
	EnvAdd, Mon1Left1, 50
	WinMove, Windows Media Center, , %mon1left1%, 0 , 1246
	Sleep, 500
	WinMove, Windows Media Center, , %mon1left1%, 0 , 1246
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon2-768:
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, 20
	WinMove, Windows Media Center, , %Mon2Left1%, 0, 1317
	sleep, 500
	WinMove, Windows Media Center, , %Mon2Left1%, 0, 1317
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon3-768:
	IfEqual, Mon3Bottom , 900, goto, mon3-900
	IfEqual, Mon3Bottom , 1050, goto, mon3-1050
	IfEqual, Mon3Bottom , 1080, goto, mon3-1080
	SetEnv, Mon3Left1, %Mon3Left%
	EnvAdd, Mon3Left1, 20
	SetEnv, Mon2Right1, %Mon2Right%
	WinMove, Windows Media Center, , %Mon3Left1%, 0 , 1317
	sleep, 500
	WinMove, Windows Media Center, , %Mon3Left1%, 0 , 1317
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run
900:
	IfEqual, gotomon ,2 , Goto, mon2-900
	IfEqual, gotomon ,3 , Goto, mon3-900
	SetEnv, Mon1Left1, %Mon1Left%
	EnvAdd, Mon1Left1, 55
	WinMove, Windows Media Center, , %Mon1Left1%, 0, 1480
	sleep, 500
	WinMove, Windows Media Center, , %Mon1Left1%, 0, 1480
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon2-900:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, 30
	WinMove, Windows Media Center, , %Mon2Left1%, 0, 1550
	sleep, 500
	WinMove, Windows Media Center, , %Mon2Left1%, 0, 1550
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon3-900:
	IfEqual, Mon3Bottom , 768, goto, mon3-768
	IfEqual, Mon3Bottom , 1050, goto, mon3-1050
	IfEqual, Mon3Bottom , 1080, goto, mon3-1080
	SetEnv, Mon3Left1, %Mon3Left%
	EnvAdd, Mon3Left1, 30
	WinMove, Windows Media Center, , %Mon3Left1%, 0, 1550
	sleep, 500
	WinMove, Windows Media Center, , %Mon3Left1%, 0, 1550
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
	IfEqual, gotomon ,3 , Goto, mon3-1050
	WinMove, Windows Media Center, , 0, 19 , 1680
	sleep, 500
	WinMove, Windows Media Center, , 0, 19 , 1680
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon2-1050:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	WinMove, Windows Media Center, , %Mon2Left%, 40 , 1680
	sleep, 500
	WinMove, Windows Media Center, , %Mon2Left%, 40 , 1680
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon3-1050:
	IfEqual, Mon3Bottom , 768, goto, mon3-768
	IfEqual, Mon3Bottom , 900, goto, mon3-900
	IfEqual, Mon3Bottom , 1080, goto, mon3-1080
	WinMove, Windows Media Center, , %Mon3Left%, 40 , 1680
	sleep, 500
	WinMove, Windows Media Center, , %Mon3Left%, 40 , 1680
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
	IfEqual, gotomon ,3 , Goto, mon3-1080

	WinMove, Windows Media Center, , 52, 0 , 1800
	sleep, 500
	WinMove, Windows Media Center, , 52, 0 , 1800
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon2-1080:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, 30
	WinMove, Windows Media Center,, %Mon2Left1%, 0, 1855,
	sleep, 500
	WinMove, Windows Media Center,, %Mon2Left1%, 0, 1855,
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

	mon3-1080:
	IfEqual, Mon3Bottom , 768, goto, mon3-768
	IfEqual, Mon3Bottom , 900, goto, mon3-900
	IfEqual, Mon3Bottom , 1050, goto, mon3-1050
	;; msgbox, Ecran 2 -- mon2Left=%Mon2Left% -- Top=%Mon2Top% -- Right=%Mon2Right% -- Bottom=%Mon2Bottom% -- gotomon=%gotomon% -- Mon3Left1=%Mon3Left1%
	;; WinMove, Windows Media Center, , %Mon2Left%, 0 , 1800
	;; WinMove, WinTitle, WinText, X, Y, Width, Height
	SetEnv, Mon3Left1, %Mon3Left%
	EnvAdd, Mon3Left1, 30
	WinMove, Windows Media Center,, %Mon3Left1%, 0 , 1855,
	Sleep, 500
	WinMove, Windows Media Center,, %Mon3Left1%, 0 , 1855,
	WinActivate, Windows Media Center
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

Default:
	;;MsgBox, Ecran 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%... Default
	SetEnv, Var1, %Mon1Right%
	SetEnv, Var2, 100
	var1 -= var2
	SetEnv, Var3, %Mon1Bottom%
	SetEnv, Var4, 100			;; -40 win bar +-20 i don't know why
	var3 -= var4
	;;Msgbox x25 y25 w%Var1% h%Var3% Visual NEW position (ESC exit) (OK continue)
	sleep, 500
	Menu, Tray, Icon, ico_yellow.ico
	WinMove, Windows Media Center, , 50, 50 , %Var1%, ;;%Var3%
	WinActivate, Windows Media Center
	Goto, Run

;;--- Quit (escape , esc) ---

ExitApp:
GuiClose2:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode% by %author%, 2, 1
	Sleep, 500
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
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