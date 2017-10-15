;;--- Head --- Informations --- AHK ---

;;	File name: WMC fitscreen.exe
;;	Windows Media Center Fit Screen. Best fit for WMC without full screen. On monitor 1 or 2.
;;	Ajusted resolutions: 1366 x 768 1600 x 900  1680 x 1050  1920 x 1080
;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	Version 2017-03-08 - 2 screen supported.
;;	; mean functionnal but disabled and mayby work on it
;;	;; mean unfunctionnal and be never it
;;	Windows 7 maybe intermix monitor numbers ; ex: the 2 is primary and 1 is extended. This software not supposed to have unexpected random errors with that.
;;	2017-05-05 3 screen supported
;;	2017-09-08-1759 bug track and modifications

;;--- Softwares Variables ---

	Menu, Tray, Icon, ico_yellow.ico

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	;; #NoEnv				; Must be deactivated, Cause error to determine if WMC is installed or not
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, WMC FitScreen
	SetEnv, mode, WMC Best Fit Screen : F6
	SetEnv, version, Version 2017-10-15-1113
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, ico_green.ico

	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	SysGet, Mon3, Monitor, 3

;;--- Softwares options ---

	FileInstall, WMCfitscreen.ini, WMCfitscreen.ini, 0
	FileInstall, icons\ico_green.ico, ico_green.ico, 0
	FileInstall, icons\ico_yellow.ico, ico_yellow.ico, 0
	FileInstall, icons\ico_red.ico, ico_red.ico, 0
	FileInstall, icons\ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, icons\ico_shut.ico, ico_shut.ico, 0
	FileInstall, icons\ico_wmc.ico, ico_wmc.ico, 0
	FileInstall, icons\ico_lock.ico, ico_lock.ico, 0
	FileInstall, icons\ico_about.ico, ico_about.ico, 0
	FileInstall, icons\ico_full.ico, ico_full.ico, 0
	FileInstall, icons\ico_monitor.ico, ico_monitor.ico, 0
	FileInstall, icons\ico_minimize.ico, ico_minimize.ico, 0
	FileInstall, icons\ico_maximize.ico, ico_maximize.ico, 0
	FileInstall, icons\ico_mute.ico, ico_mute.ico, 0
	FileInstall, icons\ico_1.ico, ico_1.ico, 0
	FileInstall, icons\ico_2.ico, ico_2.ico, 0
	FileInstall, icons\ico_3.ico, ico_3.ico, 0
	FileInstall, icons\ico_volume_2.ico, ico_volume_2.ico, 0
	FileInstall, icons\ico_options.ico, ico_options.ico, 0
	FileInstall, icons\ico_HotKeys.ico, ico_HotKeys.ico, 0
	FileInstall, icons\ico_pause.ico, ico_pause.ico, 0
	FileInstall, icons\ico_green_pause.ico, ico_green_pause.ico, 0
	FileInstall, icons\ico_debug.ico, ico_debug.ico, 0

	IniRead, start, WMCfitscreen.ini, options, start
	IniRead, autorun, WMCfitscreen.ini, options, autorun
	IniRead, timer, WMCfitscreen.ini, options, timer
	IniRead, debug, WMCfitscreen.ini, options, debug
	IniRead, minimize, WMCfitscreen.ini, options, minimize
	IniRead, hotkeyf2, WMCfitscreen.ini, options, hotkeyf2
	IniRead, hotkeyf3, WMCfitscreen.ini, options, hotkeyf3
	IniRead, hotkeyf4, WMCfitscreen.ini, options, hotkeyf4
	IniRead, hotkeyF5, WMCfitscreen.ini, options, hotkeyF5
	IniRead, gotomon, WMCfitscreen.ini, options, gotomon
	IniRead, pausekey, WMCfitscreen.ini, options, pausekey
	IfEqual, Monitorcount, 1, IniWrite, 1, WMCfitscreen.ini, options, gotomon

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control %title% ==--, about
	Menu, Tray, Icon, --== Control %title% ==--, ico_options.ico
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), ico_debug.ico
	Menu, tray, add, Pause all (Toggle), pause2
	Menu, Tray, Icon, Pause all (Toggle), ico_pause.ico
	Menu, tray, add,
	menu, tray, add, --== Options General ==--, about
	Menu, Tray, Icon, --== Options General ==--, ico_options.ico
	Menu, tray, add, Autorun On/Off = %autorun%, autorunonoff		; autorun
	Menu, Tray, Icon, Autorun On/Off = %autorun%, ico_options.ico
	menu, tray, add, Start Timer = %timer% (If autorun=1), timerset
	;menu, tray, disable, Start Timer = %timer% (If autorun=1)
	Menu, Tray, Icon, Start Timer = %timer% (If autorun=1), ico_options.ico
	Menu, tray, add, Minimize start = %minimize%, about
	menu, tray, disable, Minimize start = %minimize%
	Menu, tray, add, Open WMCfitscreen.ini, openini
	Menu, Tray, Icon, Open WMCfitscreen.ini, ico_options.ico
	menu, tray, add
	menu, tray, add, --== Options Monitor Select ==--, about
	Menu, Tray, Icon, --== Options Monitor Select ==--, ico_monitor.ico
	menu, Tray, add, Screen Choice && Gotomon = %gotomon%, screenselecttray
	Menu, Tray, Icon, Screen Choice && Gotomon = %gotomon%, ico_monitor.ico
	menu, tray, add
	menu, tray, add, --== Keyboard Hotkeys ==--, about
	Menu, Tray, Icon, --== Keyboard Hotkeys ==--, ico_HotKeys.ico
	Menu, threetree, Add, Pause (Toggle) Hotkey's = 0ff, pause
	Menu, threetree, Icon, Pause (Toggle) Hotkey's = 0ff, ico_HotKeys.ico
	menu, threetree, add
	menu, threetree, add, WMC default hotkey, about
	menu, threetree, disable, WMC default hotkey
	Menu, threetree, add, Hotkey: F8 - Mute, mute
	Menu, threetree, Icon, Hotkey: F8 - Mute, ico_volume_2.ico
	Menu, threetree, Add, Hotkey: F9 - Volume Up, about
	Menu, threetree, Icon, Hotkey: F9 - Volume Up, ico_HotKeys.ico
	Menu, threetree, Add, Hotkey: F10 - Volume Down, about
	Menu, threetree, Icon, Hotkey: F10 - Volume Down, ico_HotKeys.ico
	menu, tray, add, --== Hotkeys ==--, :threetree
	Menu, Tray, Icon, --== Hotkeys ==--, ico_HotKeys.ico
	Menu, Tray, Add, Hotkey: F2 Monitor 1 (If exist), ButtonScreen_1
	Menu, Tray, Icon, Hotkey: F2 Monitor 1 (If exist), ico_1.ico
	Menu, Tray, Add, Hotkey: F3 Monitor 2 (If exist), ButtonScreen_2
	Menu, Tray, Icon, Hotkey: F3 Monitor 2 (If exist), ico_2.ico
	Menu, Tray, Add, Hotkey: F4 Monitor 3 (If exist), ButtonScreen_3
	Menu, Tray, Icon, Hotkey: F4 Monitor 3 (If exist), ico_3.ico
	Menu, tray, Add, Hotkey: F5 Minimize, minimize
	Menu, tray, Icon, Hotkey: F5 Minimize, ico_minimize.ico
	Menu, tray, add, Keyboard Hotkey need activation (ini), about
	menu, tray, disable, Keyboard Hotkey need activation (ini)
	menu, tray, add
	Menu, fourtree, add, WMC Exit / Close, wmcclose				; Close or Exit WMC, useful when in nochrome mode
	Menu, fourtree, Icon, WMC Exit / Close, ico_shut.ico
	Menu, fourtree, add, WMC Full Screen, fullscreen			; Fullscreen
	Menu, fourtree, Icon, WMC Full Screen, ico_full.ico
	Menu, fourtree, add, WMC Minimize, minimize				; minimize
	Menu, fourtree, Icon, WMC minimize, ico_minimize.ico
	Menu, fourtree, add, WMC Maximize, Maximize				; Maximize
	Menu, fourtree, Icon, WMC Maximize, ico_Maximize.ico
	menu, tray, add, -= Control WMC =-,  :fourTree
	Menu, Tray, Icon, -= Control WMC =-, ico_HotKeys.ico
	menu, tray, add
	menu, tray, add, --== Start Options ==--, about
	Menu, tray, add, Start / Move / minimize, SimpleStartmin		; Run the script.
	Menu, Tray, Icon, Start / Move / minimize, ico_wmc.ico
	Menu, tray, add, Start / Move, SimpleStartmove				; Run the script.
	Menu, Tray, Icon, Start / Move, ico_wmc.ico
	Menu, tray, add, F6 Start / Move / Options, F6startmoveoptions		; Run the script.
	Menu, Tray, Icon, F6 Start / Move / Options, ico_wmc.ico
	menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

	IfNotExist, WMCfitscreen.ini, FileInstall, WMCfitscreen.ini, WMCfitscreen.ini, 0
	IfNotExist, %windir%\ehome\ehshell.exe, Goto, error_01
	IfEqual, hotkeyf2, 1, Run, "wmc_monitor1.exe"
	IfEqual, hotkeyf3, 1, Run, "wmc_monitor2.exe"
	IfEqual, hotkeyf4, 1, Run, "wmc_monitor3.exe"
	IfEqual, hotkeyf5, 1, Run, "wmc_minimize.exe"
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	IfEqual, pausekey, 1, Menu, threetree, rename, Pause (Toggle) Hotkey's = 0ff, Pause (Toggle) Hotkey's = On
	IfEqual, pausekey, 1, Menu, threetree, Icon, Pause (Toggle) Hotkey's = On, ico_pause.ico
	IfWinExist, Windows Media Center,, goto, maxstart
	IniRead, start, WMCfitscreen.ini, options, start
	IfEqual, Autorun, 1, Goto, Start
	Goto, run

run:
	Ifequal, pause, 1, goto, pause3
	Menu, Tray, Icon, ico_green.ico
	IfEqual, debug, 1, MsgBox, Run : in waiting to press F6	
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	KeyWait, F6, D
	Menu, Tray, Icon, ico_red.ico
	IfWinExist, Windows Media Center,, goto, move
	IniRead, start, WMCfitscreen.ini, options, start
	goto, start

;; --- Start Options ---

start:
	Menu, Tray, Icon, ico_yellow.ico
	IfWinExist, Windows Media Center,, goto, move
	;; MsgBox, t_UpTime=%t_UpTime% timer=%timer% sleep time=%timer%000
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	IfGreater, t_UpTime, %delay%, goto, skip	; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	sleep, %delay%000
	skip:
	Menu, Tray, Icon, ico_red.ico
	run, "%windir%\ehome\ehshell.exe" %start%
	sleep, 1000
	WinWait, Windows Media Center
	Menu, Tray, Icon, ico_yellow.ico
	sleep, 1000
	WinActivate, Windows Media Center
	goto, move

	SimpleStartmove:
		SetEnv, start, /widescreen /nostartupanimation
		goto, start

	maxstart:
		Menu, Tray, Icon, ico_yellow.ico
		WinActivate, Windows Media Center
		goto, move

	F6startmoveoptions:
		IniRead, start, WMCfitscreen.ini, options, start
		goto, start

	SimpleStartmin:
		SetEnv, start, /widescreen /nostartupanimation
		SetEnv, minimize, 1
		goto, start

;; --- End Start Options ---

move:
	Menu, Tray, Icon, ico_yellow.ico
	IfEqual, debug, 1, MsgBox, Move : It will move WMC
	WinActivate, Windows Media Center
	Sleep, 500
	IniRead, gotomon, WMCfitscreen.ini, options, gotomon
	IfEqual, Mon1Bottom , 768, goto, 768
	IfEqual, Mon1Bottom , 900, goto, 900
	IfEqual, Mon1Bottom , 1050, goto, 1050
	IfEqual, Mon1Bottom , 1080, goto, 1080
	MsgBox, ERROR_01 You screen is not supported. Goto Default values. It could be not best adjust. (Fail to detect resolution)
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
	IfEqual, gotomon ,3 , Goto, mon3-1050
	WinMove, Windows Media Center, , 0, 19 , 1680
	sleep, 500
	WinMove, Windows Media Center, , 0, 19 , 1680
	WinActivate, Windows Media Center
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
	IfEqual, gotomon ,3 , Goto, mon3-1080

	WinMove, Windows Media Center, , 52, 0 , 1800
	sleep, 500
	WinMove, Windows Media Center, , 52, 0 , 1800
	WinActivate, Windows Media Center
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
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
	IfEqual, minimize, 1, goto, minimize
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

Default:
	;; MsgBox, Ecran 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%... Default
	SetEnv, Var1, %Mon1Right%
	SetEnv, Var2, 100
	var1 -= var2
	SetEnv, Var3, %Mon1Bottom%
	SetEnv, Var4, 100			;; -40 win bar +-20 i don't know why
	var3 -= var4
	;; Msgbox x25 y25 w%Var1% h%Var3% Visual NEW position (ESC exit) (OK continue)
	sleep, 500
	WinMove, Windows Media Center, , 50, 50 , %Var1%, ;; %Var3%
	Sleep, 500
	WinMove, Windows Media Center, , 50, 50 , %Var1%, ;; %Var3%
	WinActivate, Windows Media Center
	IfEqual, minimize, 1, goto, minimize
	Menu, Tray, Icon, ico_green.ico
	Goto, Run

;--- Gui start ---

	screenselecttray:
		Menu, Tray, Icon, ico_yellow.ico
		setenv oldvalue, %gotomon%
		;setenv gotomon1, %gotomon%

	screenselectgui2:
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		Gui, Add, Button, x350 y130 w75 h30 , Cancel
		Gui, Add, Text, x5 y5 w358 h98 , On witch monitor do you want to adjust WMC ? (If running it will move)`n`n`t(3 monitor supported maximum)`n`tActual monitor:`t%gotomon%`n`tMonitor Count:`t%MonitorCount%`n`tPrimary Monitor:`t%MonitorPrimary%
		Gui, Add, Button, x50 y130 w75 h30 , Screen_1
		Gui, Add, Button, x150 y130 w75 h30 , Screen_2
		Gui, Add, Button, x250 y130 w75 h30 , Screen_3
		Gui, Add, Text, x28 y100 w430 h15 , Click on monitor you want WMC and move it immediately. (only if WMC is already started.)
		Gui, Show, x1095 y420 h200 w475, %title%
		Return

	ButtonCancel:
		Gui, destroy
		Menu, Tray, Icon, ico_green.ico
		IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
		IfWinNotExist, Windows Media Center,,,, Goto, Run
		goto, Start

	ButtonScreen_1:
		Menu, Tray, Icon, ico_yellow.ico
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		IniWrite, 1, WMCfitscreen.ini, options, gotomon
		SetEnv, gotomon, 1
		IFEqual, OldGotomon, 1, Goto, Skip5
		Menu, Tray, Rename, Screen Choice && Gotomon = %oldgotomon%, Screen Choice && Gotomon = 1
		skip5:
		goto, ButtonCancel

	ButtonScreen_2:
		Menu, Tray, Icon, ico_yellow.ico
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		IfEqual, Monitorcount, 1, Goto, Monitorcounterror
		IniWrite, 2, WMCfitscreen.ini, options, gotomon
		SetEnv, gotomon, 2
		IFEqual, OldGotomon, 2, Goto, Skip6
		Menu, Tray, Rename, Screen Choice && Gotomon = %oldgotomon%, Screen Choice && Gotomon = 2
		Skip6:
		goto, ButtonCancel

	ButtonScreen_3:
		Menu, Tray, Icon, ico_yellow.ico
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		IfEqual, Monitorcount, 1, Goto, Monitorcounterror
		IfEqual, Monitorcount, 2, Goto, Monitorcounterror
		IniWrite, 3, WMCfitscreen.ini, options, gotomon
		SetEnv, gotomon, 3
		IFEqual, OldGotomon, 3, Goto, Skip7
		Menu, Tray, Rename, Screen Choice && Gotomon = %oldgotomon%, Screen Choice && Gotomon = 3
		skip7:
		goto, ButtonCancel

	Monitorcounterror:
		Gui, destroy
		Goto, screenselecttray

;--- Gui end ---

minimize:
	Menu, Tray, Icon, ico_yellow.ico
	WinMinimize, Windows Media Center
	Sleep, 1000
	SetEnv, minimize, 0
	goto, run

maximize:
	Menu, Tray, Icon, ico_yellow.ico
	WinActivate, Windows Media Center
	; Winmaximize, Windows Media Center
	Sleep, 1000
	goto, move

openini:
	Menu, Tray, Icon, ico_yellow.ico
	run, notepad.exe "WMCfitscreen.ini"
	Sleep, 1000
	goto, run

mute:
	Menu, Tray, Icon, ico_yellow.ico
	IfEqual, mute, 1, goto, unmute
	SetEnv, mute, 1
	Menu, Tray, Icon, Hotkey: F8 - Mute, ico_mute.ico, 1
	WinActivate, Windows Media Center
	send, {F8}
	sleep, 500
	goto, run

	Unmute:
	SetEnv, mute, 0
	Menu, Tray, Icon, Hotkey: F8 - Mute, ico_volume_2.ico, 1
	WinActivate, Windows Media Center
	send, {F8}
	sleep, 500
	goto, run

timerset:
	Menu, Tray, Icon, ico_yellow.ico
	IniRead, timer, WMCfitscreen.ini, options, timer
	SetENv, oldtimer, %timer%
	InputBox, newtimer, WMC fitscreen, Set new timer start in seconds ? Now time is %timer% sec. Set between 1 and 240 seconds
		if ErrorLevel
			goto, run
	IniWrite, %newtimer%, WMCfitscreen.ini, options, timer
	;msgbox, old=%oldtimer%000 ... new=%newtimer%000
	IfGreater, newtimer, 240, Goto, Timerset
	IfLess, newtimer, 0, Goto, Timerset
	Menu, Tray, Rename, Start Timer = %oldtimer% (If autorun=1), Start Timer = %newtimer% (If autorun=1)
	sleep, 500
	goto, run

pause:
	Menu, Tray, Icon, ico_yellow.ico
	IfEqual, pausekey, 1, goto, unpause
	IniWrite, 1, WMCfitscreen.ini, options, pausekey
	Menu, Tray, Icon, ico_green_pause.ico
	Menu, threetree, rename, Pause (Toggle) Hotkey's = 0ff, Pause (Toggle) Hotkey's = On
	Menu, threetree, Icon, Pause (Toggle) Hotkey's = On, ico_pause.ico
	SetEnv, pausekey, 1
	Goto, Run

	unpause:
	Menu, threetree, Icon, Pause (Toggle) Hotkey's = On, ico_HotKeys.ico
	IniWrite, 0, WMCfitscreen.ini, options, pausekey
	Menu, threetree, rename, Pause (Toggle) Hotkey's = On, Pause (Toggle) Hotkey's = 0ff
	Menu, Tray, Icon, ico_green.ico
	SetEnv, pausekey, 0
	Goto, Run

error_01:
	Random, error, 1111, 9999
	MsgBox, ERROR_%error% WMC not installed (Install WMC). An error occur. Program close...
	goto, ExitApp

;;--- Quit (escape , esc) debug & pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0
	debug0:
	;Menu, Tray, Rename, Debug MsgBox = 1, Debug MsgBox = 0
	SetEnv, debug, 0
	goto, run
	debug1:
	;Menu, Tray, Rename, Debug MsgBox = 0, Debug MsgBox = 1
	SetEnv, debug, 1
	goto, run

pause2:
	IfEqual, debug, 1, MsgBox, pause2 :
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused
	paused:
	Menu, Tray, Icon, ico_green_pause.ico
	SetEnv, pause, 1
	goto, pause3
	unpaused:
	SetEnv, pause, 0
	Goto, run
	pause3:
	sleep, 120000
	goto, pause3

doReload:
	Menu, Tray, Icon, ico_yellow.ico
	Reload
	sleep, 500

ExitApp:
	Process, Close, wmc_monitor1.exe
	Process, Close, wmc_monitor2.exe
	Process, Close, wmc_monitor3.exe
	Process, Close, wmc_minimize.exe
	ExitApp

Escape::					; Debug purpose
	IfEqual, debug, 0, goto, run
	Process, Close, wmc_monitor1.exe
	Process, Close, wmc_monitor2.exe
	Process, Close, wmc_monitor3.exe
	Process, Close, wmc_minimize.exe
	ExitApp

GuiClose:
	Gui, destroy
	Goto, run

;;--- Tray Bar (must be at end of file) ---

wmcclose:
	Menu, Tray, Icon, ico_red.ico
	WinClose, Windows Media Center
	sleep, 1000
	goto, run

secret:
	Menu, Tray, Icon, ico_yellow.ico
	IniRead, autorun, WMCfitscreen.ini, options, autorun
	IniRead, timer, WMCfitscreen.ini, options, timer
	IniRead, start, WMCfitscreen.ini, options, start
	IniRead, minimize, WMCfitscreen.ini, options, minimize
	IniRead, hotkeyf2, WMCfitscreen.ini, options, hotkeyf2
	IniRead, hotkeyf3, WMCfitscreen.ini, options, hotkeyf3
	IniRead, hotkeyf4, WMCfitscreen.ini, options, hotkeyf4
	IniRead, hotkeyF5, WMCfitscreen.ini, options, hotkeyF5
	IniRead, gotomon, WMCfitscreen.ini, options, gotomon
	IniRead, pausekey, WMCfitscreen.ini, options, pausekey
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	SysGet, Mon3, Monitor, 3
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	MsgBox, 64, WMC Fit Screen, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author% t_UpTime=%t_UpTime% A_WorkingDir=%A_WorkingDir%`n`nHotkey= F2=%hotkeyf2% F3=%hotkeyf3% F4=%hotkeyf4% F5=%hotkeyF5% F6=1`n`nautorun=%autorun% timer=%timer% minimize=%minimize% Gotomon=%gotomon%`n`nstart=%start% %fullscreenstar2t%`n`nMonitorCount=%MonitorCount% MonitorPrimary=%MonitorPrimary%`n`nMon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%`n`nMon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.`n`nMon 3 Left: %Mon3Left% -- Top: %Mon3Top% -- Right: %Mon3Right% -- Bottom %Mon3Bottom%.
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

autorunonoff:
	Menu, Tray, Icon, ico_red.ico
	IfEqual, autorun, 1, goto, disableautorun
	IfEqual, autorun, 0, goto, enableautorun
	msgbox, error_03 autorunonoff error
	Return

	enableautorun:
	Menu, Tray, Icon, ico_yellow.ico
	IniWrite, 1, WMCfitscreen.ini, options, autorun
	SetEnv, autorun, 1
	TrayTip, %title%, Autorun enabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 0, Autorun On/Off = 1
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

	disableautorun:
	Menu, Tray, Icon, ico_yellow.ico
	IniWrite, 0, WMCfitscreen.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 1, Autorun On/Off = 0
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

about:
	Menu, Tray, Icon, ico_yellow.ico
	TrayTip, %title%, %mode% by %author%, 2, 1
	Sleep, 500
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

version:
	Menu, Tray, Icon, ico_yellow.ico
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

fullscreen:
	Menu, Tray, Icon, ico_yellow.ico
	WinActivate, Windows Media Center
	sleep, 500
	send, !{enter}
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to place automaticly WMC for best fit. 1 2 or 3 monitors supported.`n`n`tGo to https://github.com/LostByteSoft
	Return

GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , ico_green.ico
	Gui, Show, w450 h450, %title% Logo
	Gui, Color, 000000
	return


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