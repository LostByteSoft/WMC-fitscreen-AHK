;;--- Head --- Informations --- AHK ---

;;	File name: wmc_minimize.exe

;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Variables ---

	SetEnv, title, WMC F5 Minimize
	SetEnv, mode, Hotkey : F5 minimize only if activated
	SetEnv, version, Version 2017-04-23
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv
	SetTitleMatchMode, 2

	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_1.ico, ico_1.ico, 0
	FileInstall, ico_2.ico, ico_2.ico, 0
	FileInstall, ico_wmc.ico, ico_wmc.ico, 0
	FileInstall, ico_HotKeys.ico, ico_HotKeys.ico
	FileInstall, ico_minimize.ico, ico_minimize.ico

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= WMC FitScreen =--, about
	Menu, Tray, Icon, --= WMC FitScreen =--, ico_wmc.ico, 1
	Menu, tray, add
	Menu, tray, add, Exit, ExitApp
	Menu, Tray, Icon, Exit, ico_shut.ico
	Menu, tray, add, Deactivate HotKey, Deactivate
	Menu, Tray, Icon, Deactivate HotKey, ico_minimize.ico
	Menu, tray, add
	Menu, tray, add, About - LostByteSoft, about
	Menu, Tray, Icon, About - LostByteSoft, ico_about.ico, 1
	Menu, tray, add, %Version% , version
	Menu, Tray, Icon, %Version%, ico_about.ico, 1
	Menu, tray, add
	Menu, tray, add, Hotkey: F5 MiniMize, hotkeyf5
	Menu, Tray, Icon, Hotkey: F5 MiniMize, ico_HotKeys.ico, 1
	Menu, Tray, Tip, %title%

;;--- Software start here ---

	; TrayTip, %title%, %mode%, 2, 1

start:
	KeyWait, F5, D
	WinGetTitle, OutputVar, A
	Ifequal, OutputVar, Windows Media Center, Goto, minimize
	Goto, Start

minimize:
	hotkeyf5:
	WinMinimize, Windows Media Center
	Sleep, 1000
	goto, start

Deactivate:
	IniWrite, 0, WMC fitscreen.ini, options, hotkeyf5
	Goto, ExitApp

;;--- Quit (escape , esc) ---

ExitApp:
	ExitApp

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