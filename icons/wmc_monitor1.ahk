;;--- Head --- Informations --- AHK ---

;;	File name: wmc_monitor1.exe

;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Variables & Options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, WMC F2 move to monitor 1
	SetEnv, mode, Fit Screen : HotKey F3
	SetEnv, version, Version 2017-11-23-1355
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files

	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_1.ico, %icofolder%\ico_1.ico, 0

	Menu, Tray, NoStandard
	Menu, tray, add, Exit, Exitapp
	Menu, Tray, Icon, Exit, %icofolder%\ico_shut.ico
	Menu, tray, add, Deactivate HotKey, Deactivate
	Menu, Tray, Icon, Deactivate HotKey, %icofolder%\ico_1.ico
	Menu, tray, add, Hotkey: F2 Monitor 1, run2
	Menu, Tray, Icon, Hotkey: F2 Monitor 1, %icofolder%\ico_HotKeys.ico
	Menu, Tray, Tip, %title%

;;--- Software start here ---

run:
	Menu, Tray, Icon, %icofolder%\ico_1.ico
	KeyWait, F2, D
	IniRead, pausekey, WMCfitscreen.ini, options, pausekey
	IfEqual, pausekey, 1, Goto, inpause
	run2:
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	SetEnv, gotomon, 1
	IniWrite, 1, WMCfitscreen.ini, options, gotomon
	IniRead, overscan, WMCfitscreen.ini, options, overscan
	IniRead, hotkeyf2, WMCfitscreen.ini, options, hotkeyf2
	IniRead, hotkeyf3, WMCfitscreen.ini, options, hotkeyf3
	IfEqual, MonitorCOunt, 1, SetEnv, gotomon, 1
	IfEqual, MonitorCOunt, 1, IniWrite, 1, WMCfitscreen.ini, options, gotomon
	IfWinExist, Windows Media Center,, goto, move
	Goto, Run

inpause:
	sleep, 120000
	Goto, run

move:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IniRead, gotomon, WMCfitscreen.ini, options, gotomon
	IfEqual, Mon1Bottom , 768, goto, 768
	IfEqual, Mon1Bottom , 900, goto, 900
	IfEqual, Mon1Bottom , 1050, goto, 1050
	IfEqual, Mon1Bottom , 1080, goto, 1080
	;MsgBox, You screen is not supported. Goto Default values. It could be not best adjust. (Fail to detect resolution)
	goto, Default

768:
	IfEqual, gotomon, 2, Goto, mon2-768
	SetEnv, Mon1Left1, %Mon1Left%
	EnvAdd, Mon1Left1, 50
	WinMove, Windows Media Center, , 50, %Mon1Top% , 1246
	Sleep, 250
	WinMove, Windows Media Center, , 50, %Mon1Top% , 1246
	WinActivate, Windows Media Center
	Goto, Run

	mon2-768:
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	IfEqual, overscan, 1, goto, 768over
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, 20
	WinMove, Windows Media Center, , %Mon2Left1%, %Mon2Top%, 1317
	sleep, 250
	WinMove, Windows Media Center, , %Mon2Left1%, %Mon2Top%, 1317
	WinActivate, Windows Media Center
	Goto, Run

	768over:
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, -7
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1356,
	sleep, 250
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1356,
	WinActivate, Windows Media Center
	Goto, Run

900:
	IfEqual, gotomon ,2 , Goto, mon2-900
	SetEnv, Mon1Left1, %Mon1Left%
	EnvAdd, Mon1Left1, 55
	WinMove, Windows Media Center, , %Mon1Left1%, %Mon1Top%, 1480
	sleep, 250
	WinMove, Windows Media Center, , %Mon1Left1%, %Mon1Top%, 1480
	WinActivate, Windows Media Center
	Goto, Run

	mon2-900:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, 30
	WinMove, Windows Media Center, , %Mon2Left1%, %Mon2Top%, 1550
	sleep, 250
	WinMove, Windows Media Center, , %Mon2Left1%, %Mon2Top%, 1550
	WinActivate, Windows Media Center
	Goto, Run

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
	WinMove, Windows Media Center, , 0, 19, 1680
	sleep, 250
	WinMove, Windows Media Center, , 0, 19, 1680
	WinActivate, Windows Media Center
	Goto, Run

	mon2-1050:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	WinMove, Windows Media Center, , %Mon2Left%, 40 , 1680
	sleep, 250
	WinMove, Windows Media Center, , %Mon2Left%, 40 , 1680
	WinActivate, Windows Media Center
	Goto, Run

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
	WinMove, Windows Media Center, , 52, %Mon1Top% , 1799
	sleep, 250
	WinMove, Windows Media Center, , 52, %Mon1Top% , 1799
	WinActivate, Windows Media Center
	Goto, Run

	mon2-1080:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, overscan, 1, goto, 1080over

	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, 30
	WinMove, Windows Media Center,, %Mon2Left1%, 0, 1855,
	sleep, 250
	WinMove, Windows Media Center,, %Mon2Left1%, 0, 1855,
	WinActivate, Windows Media Center
	Goto, Run

	1080over:
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, -7
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1935,
	sleep, 250
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1935,
	WinActivate, Windows Media Center
	Goto, Run

Default:
	SysGet, Mon1, MonitorWorkArea, 1
	IfEqual, Debug, 1, MsgBox, DEFAULT : Your screen is not supported. Goto Default values. It could be not best adjust. (Fail to detect resolution)`n`nEcran 1 Left=%Mon1Left% -- Top=%Mon1Top% -- Right=%Mon1Right% -- Bottom=%Mon1Bottom%`n`nMove to x=%Mon1Left% y=%MOn1Top% w=%Mon1Right% h=Default
	WinMove, Windows Media Center, , %Mon1Left%, %Mon1Top% , %Mon1Right%, %Mon1Bottom%
	Sleep, 250
	WinMove, Windows Media Center, , %Mon1Left%, %Mon1Top% , %Mon1Right%, %Mon1Bottom%
	WinActivate, Windows Media Center
	Goto, Run

;;--- Quit (escape , esc) ---

ExitApp:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

Deactivate:
	IniWrite, 0, WMCfitscreen.ini, options, hotkeyf2
	Goto, ExitApp

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