;;--- Head --- Informations --- AHK ---

;;	File name: WMC fitscreen.exe
;;	Windows Media Center Fit Screen. Best fit for WMC without full screen. On monitor 1 or 2.
;;	Ajusted resolutions: 1366 x 768 1600 x 900  1680 x 1050  1920 x 1080
;;	Compatibility: WINDOWS MEDIA CENTER ,  Windows Xp , Windows Vista , Windows 7 , Windows 8
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	; mean functionnal but disabled and mayby work on it
;;	;; mean unfunctionnal and be never it
;;	Windows 7 maybe intermix monitor numbers ; ex: the 2 is primary and 1 is extended. This software not supposed to have unexpected random errors with that.
;;	2017-03-08 - 2 screen supported.
;;	2017-05-05 - 3 screen supported
;;	2017-09-08-1759 - bug track and modifications
;;	2017-10-20-0842 - look if have at least 1 monitor connected, if not minimize, used in case want music but not powered monitor.
;;	2017-11-01-1042 - Overscan WMC to use full screen on second monitor (You must have 2 monitor). Overscan is used to put fullscreen WMC without grabbing the mouse.
;;	2017-11-01-1307 - Two monitor supported (3 before)
;;	2017-11-04-1008 - Bug tracking (so many)
;;	2018-05-12-0009 - bug tracking and some options

;;--- Softwares Variables ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	;; #NoEnv			; Must be deactivated, Cause error to determine if WMC is installed or not
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2

	SetEnv, title, WMC FitScreen
	SetEnv, mode, WMC Best Fit Screen : F6
	SetEnv, version, Version 2018-05-12-0001
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files
	SetEnv, logoicon, ico_green.ico

	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2

;;--- Softwares options ---

	;; specific files
	FileInstall, WMCfitscreen.ini, WMCfitscreen.ini, 0
	FileInstall, SoftIcons\ico_1.ico, %icofolder%\ico_1.ico, 0
	FileInstall, SoftIcons\ico_2.ico, %icofolder%\ico_2.ico, 0
	FileInstall, SoftIcons\ico_green.ico, %icofolder%\ico_green.ico, 0
	FileInstall, SoftIcons\ico_green_pause.ico, %icofolder%\ico_green_pause.ico, 0
	FileInstall, SoftIcons\ico_minimize.ico, %icofolder%\ico_minimize.ico, 0
	FileInstall, SoftIcons\ico_monitor.ico, %icofolder%\ico_monitor.ico, 0
	FileInstall, SoftIcons\ico_mute.ico, %icofolder%\ico_mute.ico, 0
	FileInstall, SoftIcons\ico_red.ico, %icofolder%\ico_red.ico, 0
	FileInstall, SoftIcons\ico_volume_2.ico, %icofolder%\ico_volume_2.ico, 0
	FileInstall, SoftIcons\ico_wmc.ico, %icofolder%\ico_wmc.ico, 0
	FileInstall, SoftIcons\ico_yellow.ico, %icofolder%\ico_yellow.ico, 0
	FileInstall, SoftIcons\ico_monitor.ico, %icofolder%\ico_monitor.ico, 0
	FileInstall, SoftIcons\ico_txt.ico, %icofolder%\ico_txt.ico, 0
	FileInstall, SoftIcons\ico_folder.ico, %icofolder%\ico_folder.ico, 0


	;; Common ico
	FileInstall, SharedIcons\ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, SharedIcons\ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, SharedIcons\ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, SharedIcons\ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, SharedIcons\ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, SharedIcons\ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, SharedIcons\ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, SharedIcons\ico_pause.ico, %icofolder%\ico_pause.ico, 0
	FileInstall, SharedIcons\ico_loupe.ico, %icofolder%\ico_loupe.ico, 0


	IniRead, start, WMCfitscreen.ini, options, start
	IniRead, autorun, WMCfitscreen.ini, options, autorun
	IniRead, timer, WMCfitscreen.ini, options, timer
	IniRead, debug, WMCfitscreen.ini, options, debug
	IniRead, minimize, WMCfitscreen.ini, options, minimize
	IniRead, hotkeyf2, WMCfitscreen.ini, options, hotkeyf2
	IniRead, hotkeyf3, WMCfitscreen.ini, options, hotkeyf3
	IniRead, hotkeyF5, WMCfitscreen.ini, options, hotkeyF5
	IniRead, gotomon, WMCfitscreen.ini, options, gotomon
	IniRead, pausekey, WMCfitscreen.ini, options, pausekey
	IniRead, overscan, WMCfitscreen.ini, options, overscan

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program.
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author				; infos about author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about					; author msg box
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about					; version of the software
	menu, tray, disable, %version%
	Menu, tray, add, Open project web page, webpage				; open web page project
	Menu, Tray, Icon, Open project web page, %icofolder%\ico_HotKeys.ico
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	menu, tray, add, Show Gui (Same as click), start			; Default gui open
	Menu, Tray, Icon, Show Gui (Same as click), %icofolder%\ico_loupe.ico
	Menu, Tray, Default, Show Gui (Same as click)
	Menu, Tray, Click, 1
	Menu, tray, add, Set Debug (Toggle), debug				; debug msg
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Open A_WorkingDir, A_WorkingDir			; open where the exe is
	Menu, Tray, Icon, Open A_WorkingDir, %icofolder%\ico_folder.ico
	Menu, tray, add, Open Source, Source
	Menu, Tray, Icon, Open Source, %icofolder%\ico_txt.ico
	Menu, tray, add,
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (Ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (Ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Pause (Toggle), pause					; pause the script
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico

	menu, fourtree, add, All default options, about
	menu, fourtree, disable, All default options
	menu, fourtree, add, start %start%, about

	menu, fourtree, add, ini options, about
	menu, fourtree, disable, ini options
	menu, fourtree, add, autorun %autorun%, about
	menu, fourtree, add, start timer %timer%, about
	menu, fourtree, add, minimize %minimize%, about
	menu, fourtree, add, gotomon %gotomon%, about
	menu, fourtree, add, hotkeyf2 %hotkeyf2%, about
	menu, fourtree, add, hotkeyf3 %hotkeyf3%, about
	menu, fourtree, add, hotkeyf5 %hotkeyf5%, about
	menu, fourtree, add, hotkeyf6 1, about
	menu, fourtree, add, pausekey %pausekey%, about
	menu, fourtree, add, debug %debug%, about

	menu, fourtree, add, soft options, about
	menu, fourtree, disable, soft options
	menu, fourtree, add, title %title%, about
	menu, fourtree, add, mode %mode%, about
	menu, fourtree, add, version %version%, about
	menu, fourtree, add, author %author%, about
	menu, fourtree, add, icofolder %icofolder%, about
	menu, fourtree, add, logoicon %logoicon%, about

	menu, fourtree, add, A_WorkingDir %A_WorkingDir%, about
	menu, fourtree, add, MonitorCount %MonitorCount%, about
	menu, fourtree, add, MonitorPrimary %MonitorPrimary%, about
	menu, fourtree, add, Overscan %overscan%, about
	menu, fourtree, add, Mon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%, about
	menu, fourtree, add, Mon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%, about

	menu, tray, add, All default options, :fourtree

	Menu, tray, add, Autorun On/Off = %autorun%, autorunonoff		; autorun
	Menu, Tray, Icon, Autorun On/Off = %autorun%, %icofolder%\ico_options.ico
	menu, tray, add, Start Timer = %timer% (If autorun=1), timerset
	Menu, Tray, Icon, Start Timer = %timer% (If autorun=1), %icofolder%\ico_options.ico
	Menu, tray, add, Minimize start = %minimize%, about
	menu, tray, disable, Minimize start = %minimize%
	Menu, tray, add, Overscan = %overscan%, about
	menu, tray, disable, Overscan = %overscan%
	Menu, tray, add, Open WMCfitscreen.ini, openini
	Menu, Tray, Icon, Open WMCfitscreen.ini, %icofolder%\ico_options.ico
	menu, tray, add
	menu, tray, add, --== Options Monitor Select ==--, about
	Menu, Tray, Icon, --== Options Monitor Select ==--, %icofolder%\ico_monitor.ico
	menu, Tray, add, Screen Choice && Gotomon = %gotomon%, screenselecttray
	Menu, Tray, Icon, Screen Choice && Gotomon = %gotomon%, %icofolder%\ico_monitor.ico
	Menu, Tray, Add, Hotkey: F2 Monitor 1 (If exist), ButtonScreen_1
	Menu, Tray, Icon, Hotkey: F2 Monitor 1 (If exist), %icofolder%\ico_1.ico
	Menu, Tray, Add, Hotkey: F3 Monitor 2 (If exist), ButtonScreen_2
	Menu, Tray, Icon, Hotkey: F3 Monitor 2 (If exist), %icofolder%\ico_2.ico
	menu, tray, add
	menu, threetree, add, WMC default hotkey, about
	menu, threetree, disable, WMC default hotkey
	Menu, threetree, add, Hotkey: F8 - Mute, mute
	Menu, threetree, Icon, Hotkey: F8 - Mute, %icofolder%\ico_volume_2.ico
	Menu, threetree, Add, Hotkey: F9 - Volume Up, about
	Menu, threetree, Icon, Hotkey: F9 - Volume Up, %icofolder%\ico_HotKeys.ico
	Menu, threetree, Add, Hotkey: F10 - Volume Down, about
	Menu, threetree, Icon, Hotkey: F10 - Volume Down, %icofolder%\ico_HotKeys.ico
	menu, tray, add, --== Hotkeys ==--, :threetree
	Menu, Tray, Icon, --== Hotkeys ==--, %icofolder%\ico_HotKeys.ico
	Menu, tray, Add, Hotkey: F5 Minimize, minimize
	Menu, tray, Icon, Hotkey: F5 Minimize, %icofolder%\ico_minimize.ico
	Menu, Tray, Add, Pause (Toggle) Hotkey's, pause
	Menu, Tray, Icon, Pause (Toggle) Hotkey's, %icofolder%\ico_HotKeys.ico
	menu, tray, add
	menu, tray, add, --== Start Options ==--, about
	Menu, tray, add, Start / Move / No Chrome, nochrome			; Run the script.
	Menu, Tray, Icon, Start / Move / No Chrome, %icofolder%\ico_wmc.ico
	Menu, tray, add, Start / Move / Play All Music, playallmusic		; Run the script.
	Menu, Tray, Icon, Start / Move / Play All Music, %icofolder%\ico_wmc.ico
	Menu, tray, add, Start / Move / Minimize, SimpleStartmin		; Run the script.
	Menu, Tray, Icon, Start / Move / Minimize, %icofolder%\ico_wmc.ico
	Menu, tray, add, Start / Move, SimpleStartmove				; Run the script.
	Menu, Tray, Icon, Start / Move, %icofolder%\ico_wmc.ico
	Menu, tray, add, F6 / Start / Move / Options, F6startmoveoptions	; Run the script.
	Menu, Tray, Icon, F6 / Start / Move / Options, %icofolder%\ico_wmc.ico
	Menu, Tray, Default, F6 / Start / Move / Options
	Menu, Tray, Click, 1
	menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IfEqual, Monitorcount, 1, IniWrite, 1, WMCfitscreen.ini, options, gotomon
	IfEqual, debug, 1, goto, skipcheckwmc
	IfNotExist, %windir%\ehome\ehshell.exe, Goto, error_01
	skipcheckwmc:
	IfEqual, hotkeyf2, 1, Run, "wmc_monitor1.exe
	IfEqual, hotkeyf3, 1, Run, "wmc_monitor2.exe"
	IfEqual, hotkeyf5, 1, Run, "wmc_minimize.exe"
	IfWinExist, Windows Media Center,, goto, move
	IfEqual, Autorun, 1, Goto, Start
	Goto, run

run:
	IfEqual, debug, 1, MsgBox, RUN : in waiting to press F6.`n`nMon1Left=%Mon1Left% Mon1top=%Mon1top% Mon1Right=%Mon1Right% Mon1Bottom=%Mon1Bottom%`n`nOverscan for 2th screen=%overscan%`n`nMon2Left=%Mon2Left% Mon2top=%Mon2top% Mon2Right=%Mon2Right% Mon2Bottom=%Mon2Bottom%`n`nIcon must be %icofolder%\ico_green.ico
	Ifequal, pause, 1, goto, pause3
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, %icofolder%\ico_green_pause.ico
	KeyWait, F6, D
	Menu, Tray, Icon, %icofolder%\ico_red.ico
	SysGet, MonitorCount, MonitorCount		;; In case res change it reload resolution.
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	IfWinExist, Windows Media Center,, goto, move
	IniRead, start, WMCfitscreen.ini, options, start
	goto, start

;; --- Start ---

start:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IfWinExist, Windows Media Center,, goto, move
	IfEqual, debug, 1, MsgBox, START : t_UpTime=%t_UpTime% timer=%timer% sleep time=%timer%000
	t_UpTime := A_TickCount // 1000				;; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	IfGreater, t_UpTime, %delay%, goto, skip		;; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	sleep, %delay%000
	skip:
	Menu, Tray, Icon, %icofolder%\ico_red.ico
	IfNotExist, %windir%\ehome\ehshell.exe, MsgBox, START : WMC not installed...
	IfNotExist, %windir%\ehome\ehshell.exe, goto, run
	run, "%windir%\ehome\ehshell.exe" %start%
	sleep, 500
	WinWait, Windows Media Center
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	sleep, 500
	WinActivate, Windows Media Center
	goto, move

;; --- Start Options ---

	SimpleStartmove:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		SetEnv, start, /widescreen /nostartupanimation
		SetEnv, minimize, 0
		goto, start

	maxstart:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		WinActivate, Windows Media Center
		goto, move

	F6startmoveoptions:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		IniRead, start, WMCfitscreen.ini, options, start
		goto, start

	SimpleStartmin:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		SetEnv, start, /widescreen /nostartupanimation
		SetEnv, minimize, 1
		goto, start

	playallmusic:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		SetEnv, start, /widescreen /nostartupanimation /playallmusic
		goto, start

	nochrome:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		SetEnv, start, /widescreen /nostartupanimation /NoChrome
		goto, start

;; --- Move & reseize ---

move:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IniRead, gotomon, WMCfitscreen.ini, options, gotomon
	IfEqual, debug, 1, MsgBox, MOVE : It will move WMC. Gotomon=%gotomon%
	WinActivate, Windows Media Center
	IfEqual, minimize, 1, goto, minimize
	IfEqual, Mon1Bottom , 768, goto, 768
	IfEqual, Mon1Bottom , 900, goto, 900
	IfEqual, Mon1Bottom , 1050, goto, 1050
	IfEqual, Mon1Bottom , 1080, goto, 1080
	goto, Default

768:
	IfEqual, gotomon, 2, Goto, mon2-768
	SetEnv, Mon1Left1, %Mon1Left%
	EnvAdd, Mon1Left1, 50
	WinMove, Windows Media Center, , 50, %Mon1Top% , 1246
	Sleep, 500
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
	sleep, 500
	WinMove, Windows Media Center, , %Mon2Left1%, %Mon2Top%, 1317
	WinActivate, Windows Media Center
	Goto, Run

	768over:
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, -7
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1356,
	sleep, 500
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1356,
	WinActivate, Windows Media Center
	Goto, Run

900:
	IfEqual, gotomon ,2 , Goto, mon2-900
	SetEnv, Mon1Left1, %Mon1Left%
	EnvAdd, Mon1Left1, 55
	WinMove, Windows Media Center, , %Mon1Left1%, %Mon1Top%, 1480
	sleep, 500
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
	sleep, 500
	WinMove, Windows Media Center, , %Mon2Left1%, %Mon2Top%, 1550
	WinActivate, Windows Media Center
	Goto, Run

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
	WinMove, Windows Media Center, , 0, 19, 1680
	sleep, 500
	WinMove, Windows Media Center, , 0, 19, 1680
	WinActivate, Windows Media Center
	Goto, Run

	mon2-1050:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	WinMove, Windows Media Center, , %Mon2Left%, 40 , 1680
	sleep, 500
	WinMove, Windows Media Center, , %Mon2Left%, 40 , 1680
	WinActivate, Windows Media Center
	Goto, Run

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
	WinMove, Windows Media Center, , 52, %Mon1Top% , 1799
	sleep, 500
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
	sleep, 500
	WinMove, Windows Media Center,, %Mon2Left1%, 0, 1855,
	WinActivate, Windows Media Center
	Goto, Run

	1080over:
	SetEnv, Mon2Left1, %Mon2Left%
	EnvAdd, Mon2Left1, -7
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1935,
	sleep, 500
	WinMove, Windows Media Center,, %Mon2Left1%, -29, 1935,
	WinActivate, Windows Media Center
	Goto, Run

Default:
	SysGet, Mon1, MonitorWorkArea, 1
	IfEqual, Debug, 1, MsgBox, DEFAULT : Your screen is not supported. Goto Default values. It could be not best adjust. (Fail to detect resolution)`n`nEcran 1 Left=%Mon1Left% -- Top=%Mon1Top% -- Right=%Mon1Right% -- Bottom=%Mon1Bottom%`n`nMove to x=%Mon1Left% y=%MOn1Top% w=%Mon1Right% h=Default
	WinMove, Windows Media Center, , %Mon1Left%, %Mon1Top% , %Mon1Right%, %Mon1Bottom%
	sleep, 500
	WinMove, Windows Media Center, , %Mon1Left%, %Mon1Top% , %Mon1Right%, %Mon1Bottom%
	WinActivate, Windows Media Center
	Goto, Run

;--- Gui start ---

	screenselecttray:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		setenv oldvalue, %gotomon%
		;setenv gotomon1, %gotomon%

	screenselectgui2:
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		Gui, Add, Button, x350 y130 w75 h30 , Cancel
		Gui, Add, Text, x5 y5 w358 h98 , On witch monitor do you want to adjust WMC ? (If running it will move)`n`n`t(2 monitor supported maximum)`n`tActual monitor:`t%gotomon%`n`tMonitor Count:`t%MonitorCount%`n`tPrimary Monitor:`t%MonitorPrimary%
		Gui, Add, Button, x50 y130 w75 h30 , Screen_1
		Gui, Add, Button, x150 y130 w75 h30 , Screen_2
		Gui, Add, Text, x28 y100 w430 h15 , Click on monitor you want WMC and move it immediately. (only if WMC is already started.)
		Gui, Show, x1095 y420 h200 w475, %title%
		Return

	ButtonCancel:
		Gui, destroy
		Menu, Tray, Icon, %icofolder%\ico_green.ico
		IfEqual, pausekey, 1, Menu, Tray, Icon, %icofolder%\ico_green_pause.ico
		IfWinNotExist, Windows Media Center,,,, Goto, Run
		goto, Start

	ButtonScreen_1:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		SysGet, MonitorCount, MonitorCount
		SysGet, MonitorPrimary, MonitorPrimary
		SysGet, Mon1, Monitor, 1
		SysGet, Mon2, Monitor, 2
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		IniWrite, 1, WMCfitscreen.ini, options, gotomon
		SetEnv, gotomon, 1
		IFEqual, OldGotomon, 1, Goto, Skip5
		Menu, Tray, Rename, Screen Choice && Gotomon = %oldgotomon%, Screen Choice && Gotomon = 1
		skip5:
		goto, ButtonCancel

	ButtonScreen_2:
		Menu, Tray, Icon, %icofolder%\ico_yellow.ico
		SysGet, MonitorCount, MonitorCount
		SysGet, MonitorPrimary, MonitorPrimary
		SysGet, Mon1, Monitor, 1
		SysGet, Mon2, Monitor, 2
		IniRead, gotomon, WMCfitscreen.ini, options, gotomon
		setenv, oldgotomon, %gotomon%
		IfEqual, Monitorcount, 1, Goto, Monitorcounterror
		IniWrite, 2, WMCfitscreen.ini, options, gotomon
		SetEnv, gotomon, 2
		IFEqual, OldGotomon, 2, Goto, Skip6
		Menu, Tray, Rename, Screen Choice && Gotomon = %oldgotomon%, Screen Choice && Gotomon = 2
		Skip6:
		goto, ButtonCancel

	Monitorcounterror:
		Gui, destroy
		Goto, screenselecttray

;--- Gui end ---

minimize:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	WinMinimize, Windows Media Center
	Sleep, 500
	SetEnv, minimize, 0
	goto, run

openini:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	run, notepad.exe "WMCfitscreen.ini"
	Sleep, 500
	goto, run

mute:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IfEqual, mute, 1, goto, unmute
	SetEnv, mute, 1
	Menu, Tray, Icon, Hotkey: F8 - Mute, %icofolder%\ico_mute.ico, 1
	WinActivate, Windows Media Center
	send, {F8}
	sleep, 500
	goto, run

	Unmute:
	SetEnv, mute, 0
	Menu, Tray, Icon, Hotkey: F8 - Mute, %icofolder%\ico_volume_2.ico, 1
	WinActivate, Windows Media Center
	send, {F8}
	sleep, 500
	goto, run

timerset:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IniRead, timer, WMCfitscreen.ini, options, timer
	SetENv, oldtimer, %timer%
	InputBox, newtimer, WMC fitscreen, Set new timer start in seconds ? Now time is %timer% sec. Set between 1 and 240 seconds
		if ErrorLevel
			goto, run
	IniWrite, %newtimer%, WMCfitscreen.ini, options, timer
	IfGreater, newtimer, 240, Goto, Timerset
	IfLess, newtimer, 0, Goto, Timerset
	Menu, Tray, Rename, Start Timer = %oldtimer% (If autorun=1), Start Timer = %newtimer% (If autorun=1)
	sleep, 500
	goto, run

pause:
	IfEqual, pausekey, 1, goto, unpause
	IniWrite, 1, WMCfitscreen.ini, options, pausekey
	SetEnv, pausekey, 1
	Goto, Run

	unpause:
	IniWrite, 0, WMCfitscreen.ini, options, pausekey
	SetEnv, pausekey, 0
	Goto, Run

error_01:
	Random, error, 1111, 9999
	MsgBox, 4112, %title%, ERROR_%error% WMC not installed (Install WMC). Program return to skipcheckwmc:. Debug option is activated.`n`n(15 sec time out to skipcheckwmc:), 15
	SetEnv, debug, 1
	goto, skipcheckwmc

wmcclose:
	Menu, Tray, Icon, %icofolder%\ico_red.ico
	WinClose, Windows Media Center
	sleep, 1000
	goto, run

autorunonoff:
	Menu, Tray, Icon, %icofolder%\ico_red.ico
	IfEqual, autorun, 1, goto, disableautorun
	IfEqual, autorun, 0, goto, enableautorun
	msgbox, error_03 autorunonoff error
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	Return

	enableautorun:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IniWrite, 1, WMCfitscreen.ini, options, autorun
	SetEnv, autorun, 1
	TrayTip, %title%, Autorun enabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 0, Autorun On/Off = 1
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, %icofolder%\ico_green_pause.ico
	Return

	disableautorun:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IniWrite, 0, WMCfitscreen.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 1, Autorun On/Off = 0
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, %icofolder%\ico_green_pause.ico
	Return

;;--- Quit (escape , esc) debug & pause ---

debug:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0
	debug0:
	IniWrite, 0, WMCfitscreen.ini, options, debug
	SetEnv, debug, 0
	goto, run

	debug1:
	IniWrite, 1, WMCfitscreen.ini, options, debug
	SetEnv, debug, 1
	goto, run

pause2:
	IfEqual, debug, 1, MsgBox, PAUSE 2 : Icon pause
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused
	paused:
	Menu, Tray, Icon, %icofolder%\ico_green_pause.ico
	SetEnv, pause, 1
	goto, pause3
	unpaused:
	SetEnv, pause, 0
	Goto, run
	pause3:
	sleep, 120000
	goto, pause3

doReload:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	Reload

ExitApp:
	Menu, Tray, Icon, %icofolder%\ico_red.ico
	Process, Close, wmc_monitor1.exe
	Process, Close, wmc_monitor2.exe
	Process, Close, wmc_minimize.exe
	ExitApp

GuiClose:
	Gui, destroy
	Goto, run

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	MsgBox, 64, WMC Fit Screen, All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author% t_UpTime=%t_UpTime% A_WorkingDir=%A_WorkingDir%`n`nHotkey= F2=%hotkeyf2% F3=%hotkeyf3% F5=%hotkeyF5% F6=1`n`nautorun=%autorun% timer=%timer% minimize=%minimize% Overscan=%overscan% Gotomon=%gotomon%`n`nstart=%start% %fullscreenstar2t%`n`nMonitorCount=%MonitorCount% MonitorPrimary=%MonitorPrimary% Overscan=%overscan%`n`nMon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%`n`nMon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, %icofolder%\ico_green_pause.ico
	Return

about:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	TrayTip, %title%, %mode% by %author%, 2, 1
	Sleep, 500
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	Return

version:
	Menu, Tray, Icon, %icofolder%\ico_yellow.ico
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull to place automaticly WMC for best fit. 1 or 2 monitors supported.`n`n`tGo to https://github.com/LostByteSoft
	Menu, Tray, Icon, %icofolder%\ico_green.ico
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	Gui, 4:Color, 000000
	Gui, 4:-MinimizeBox
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

A_WorkingDir:
	IfEqual, debug, 1, msgbox, run, explorer.exe "%A_WorkingDir%"
	run, explorer.exe "%A_WorkingDir%"
	Return

webpage:
	run, https://github.com/LostByteSoft/WMC-fitscreen-Ver-2017-11
	Return

source:
	FileInstall, WMC fitscreen.ahk, WMC fitscreen.ahk, 1
	run, "%A_ScriptDir%\WMC fitscreen.ahk"
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