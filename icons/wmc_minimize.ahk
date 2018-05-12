;;--- Head --- Informations --- AHK ---

;;	File name: wmc_minimize.exe

;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Variables ---

	SetEnv, title, WMC F5 Minimize
	SetEnv, mode, Hotkey : F5 minimize only if activated
	SetEnv, version, Version 2017-11-06-1533
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files

	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_minimize.ico, %icofolder%\ico_minimize.ico, 0
	FileInstall, ico_minimize_pause.ico, %icofolder%\ico_minimize_pause.ico, 0

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, 2

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, Exit, ExitApp
	Menu, Tray, Icon, Exit, %icofolder%\ico_shut.ico
	Menu, tray, add, Deactivate HotKey, Deactivate
	Menu, Tray, Icon, Deactivate HotKey, %icofolder%\ico_minimize.ico
	Menu, tray, add, Hotkey: F5 MiniMize, minimize
	Menu, Tray, Icon, Hotkey: F5 MiniMize, %icofolder%\ico_HotKeys.ico
	Menu, Tray, Tip, %title%

;;--- Software start here ---

start:
	Menu, Tray, Icon, %icofolder%\ico_minimize.ico
	KeyWait, F5, D
	IniRead, pausekey, WMCfitscreen.ini, options, pausekey
	IfEqual, pausekey, 1, Goto, paused

minimize:
	WinMinimize, Windows Media Center
	Sleep, 2000
	goto, start

Deactivate:
	IniWrite, 0, WMCfitscreen.ini, options, hotkeyf5
	Goto, ExitApp

paused:
	;IfEqual, pausekey, 1, Menu, Tray, Icon, %icofolder%\ico_minimize_pause.ico
	sleep, 5000
	Goto, Start

;;--- Quit (escape , esc) ---

ExitApp:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode% by %author%, 2, 1
	Return

version:
	TrayTip, %title%, %version%, 2, 2
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