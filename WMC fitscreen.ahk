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

;;--- Softwares Variables ---

	SetEnv, title, WMC FitScreen
	SetEnv, mode, WMC Best Fit Screen : F7
	SetEnv, version, Version 2017-05-20
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	;; #NoEnv					; Cause error to determine if WMC is installed or not
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper (Var timer specified in WMC fitscreen.ini) sec start imediately

	FileInstall, WMC fitscreen.ini, WMC fitscreen.ini, 0
	FileInstall, ico_green.ico, ico_green.ico, 0
	FileInstall, ico_yellow.ico, ico_yellow.ico, 0
	FileInstall, ico_red.ico, ico_red.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_wmc.ico, ico_wmc.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_full.ico, ico_full.ico, 0
	FileInstall, ico_monitor.ico, ico_monitor.ico, 0
	FileInstall, ico_minimize.ico, ico_minimize.ico, 0
	FileInstall, ico_maximize.ico, ico_maximize.ico, 0
	FileInstall, ico_mute.ico, ico_mute.ico, 0
	FileInstall, ico_1.ico, ico_1.ico, 0
	FileInstall, ico_2.ico, ico_2.ico, 0
	FileInstall, ico_3.ico, ico_3.ico, 0
	FileInstall, ico_volume_2.ico, ico_volume_2.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_HotKeys.ico, ico_HotKeys.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0
	FileInstall, ico_green_pause.ico, ico_green_pause.ico, 0

	IniRead, autorun, WMC fitscreen.ini, options, autorun
	IniRead, timer, WMC fitscreen.ini, options, timer
	IniRead, start, WMC fitscreen.ini, options, start
	IniRead, minimize, WMC fitscreen.ini, options, minimize
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen
	IniRead, hotkeyf2, WMC fitscreen.ini, options, hotkeyf2
	IniRead, hotkeyf3, WMC fitscreen.ini, options, hotkeyf3
	IniRead, hotkeyf4, WMC fitscreen.ini, options, hotkeyf4
	IniRead, hotkeyf5, WMC fitscreen.ini, options, hotkeyf5
	IniRead, gotomon, WMC fitscreen.ini, options, gotomon
	IniRead, pausekey, WMC fitscreen.ini, options, pausekey

	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	SysGet, Mon3, Monitor, 3

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= WMC FitScreen =--, about
	Menu, Tray, Icon, --= WMC FitScreen =--, ico_green.ico, 1
	menu, tray, add
	Menu, tray, add, Exit FitScreen, GuiClose2				; GuiClose exit program
	Menu, Tray, Icon, Exit FitScreen, ico_shut.ico
	Menu, tray, add, Refresh FitScreen, doReload				; Reload the script.
	Menu, Tray, Icon, Refresh FitScreen, ico_reboot.ico, 1
	menu, tray, add
	menu, tray, add, --= Options General =--, about
	Menu, Tray, Icon, --= Options General =--, ico_options.ico
	Menu, tray, Disable, --= Options General =--
	Menu, tray, add, Autorun On/Off = %autorun%, autorunonoff		; autorun
	Menu, Tray, Icon, Autorun On/Off = %autorun%, ico_options.ico, 1
	menu, tray, add, Start Timer = %timer%, timerset
	Menu, Tray, Icon, Start Timer = %timer%, ico_options.ico, 1
	Menu, tray, add, Open WMC fitscreen.ini, openini
	Menu, Tray, Icon, Open WMC fitscreen.ini, ico_options.ico, 1
	menu, tray, add
	Menu, tray, add, About - LostByteSoft, about				; Creates a new menu item.
	Menu, Tray, Icon, About - LostByteSoft, ico_about.ico, 1
	Menu, tray, add, %Version% , version					; About version
	Menu, Tray, Icon, %Version%, ico_about.ico, 1
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico, 1
	;menu, tray, add, --= Options Monitor Select =--, about
	;Menu, Tray, Icon, --= Options Monitor Select =--, ico_monitor.ico
	;Menu, tray, Disable, --= Options Monitor Select =--
 	Menu, tray, add, Screen Choice, screenselecttray		; select screen menu
	Menu, Tray, Icon, Screen Choice, ico_monitor.ico
	;Menu, TwoTree, Add, --= Click && move =--, about
	;Menu, TwoTree, Icon, --= Click && move =--, ico_monitor.ico
	;Menu, TwoTree, Disable, --= Click && move =--
	;Menu, TwoTree, Add, Monitor 1 and move, ButtonScreen_1
	;Menu, TwoTree, Icon, Monitor 1 and move, ico_1.ico
	;Menu, TwoTree, Add, Monitor 2 and move, ButtonScreen_2
	;Menu, TwoTree, Icon, Monitor 2 and move, ico_2.ico
	;Menu, TwoTree, Add, Monitor 3 and move, ButtonScreen_3
	;Menu, TwoTree, Icon, Monitor 3 and move, ico_3.ico
	;Menu, Tray, Add, Click select monitor, :TwoTree
	;Menu, Tray, Icon, Click select monitor, ico_monitor.ico
	menu, tray, add
	menu, tray, add, --= Hotkeys =--, about
	Menu, Tray, Icon, --= Hotkeys =--, ico_HotKeys.ico
	Menu, tray, Disable, --= Hotkeys =--
	Menu, tray, Add, Pause (Toggle) Hotkey's = 0ff, pause
	Menu, tray, Icon, Pause (Toggle) Hotkey's = 0ff, ico_HotKeys.ico
	Menu, tray, Add, Hotkey: F2 Monitor 1, ButtonScreen_1
	Menu, tray, Icon, Hotkey: F2 Monitor 1, ico_1.ico
	Menu, tray, Add, Hotkey: F3 Monitor 2, ButtonScreen_2
	Menu, tray, Icon, Hotkey: F3 Monitor 2, ico_2.ico
	Menu, tray, Add, Hotkey: F4 Monitor 3, ButtonScreen_3
	Menu, tray, Icon, Hotkey: F4 Monitor 3, ico_3.ico
	Menu, tray, add, Hotkey: F8 - Mute, mute
	Menu, Tray, Icon, Hotkey: F8 - Mute, ico_volume_2.ico, 1
	Menu, Tray, Add, Hotkey: F9 - Volume Up, about
	Menu, Tray, Icon, Hotkey: F9 - Volume Up, ico_HotKeys.ico
	Menu, Tray, Add, Hotkey: F10 - Volume Down, about
	Menu, Tray, Icon, Hotkey: F10 - Volume Down, ico_HotKeys.ico
	menu, tray, add
	Menu, tray, add, WMC Exit / Close, wmcclose				; Close or Exit WMC, useful when in nochrome mode
	Menu, Tray, Icon, WMC Exit / Close, ico_shut.ico
	Menu, tray, add, WMC Full Screen, fullscreen				; Fullscreen
	Menu, Tray, Icon, WMC Full Screen, ico_full.ico, 1
	Menu, tray, add, WMC Minimize, minimize					; minimize
	Menu, Tray, Icon, WMC minimize, ico_minimize.ico, 1
	Menu, tray, add, WMC Maximize, Maximize					; Maximize
	Menu, Tray, Icon, WMC Maximize, ico_Maximize.ico, 1
	menu, tray, add
	Menu, tray, add, Start / Adjust / F7 / Move, mousestart			; Run the script.
	Menu, Tray, Icon, Start / Adjust / F7 / Move, ico_wmc.ico, 1
	Menu, Tray, Tip, Windows Media Center FitScreen

;;--- Software start here ---

	Menu, Tray, Icon, ico_yellow.ico
	IfEqual, Autorun, 1, Goto, Start

run:
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	;; msgbox, waiting F7 to be pressed. gotomon=%gotomon% MonitorCount=%MonitorCount%
	KeyWait, F7, D
	Menu, Tray, Icon, ico_red.ico
	IfWinExist, Windows Media Center,, goto, move
	run, "%windir%\ehome\ehshell.exe" %start%
	sleep, 1000
	WinWait, Windows Media Center
	sleep, 1000
	WinActivate, Windows Media Center

start:
	Menu, Tray, Icon, ico_yellow.ico
	IfEqual, Monitorcount, 1, IniWrite, 1, WMC fitscreen.ini, options, gotomon
	IfEqual, hotkeyf2, 1, Run, "wmc_monitor1.exe"
	IfEqual, hotkeyf3, 1, Run, "wmc_monitor2.exe"
	IfEqual, hotkeyf4, 1, Run, "wmc_monitor3.exe"
	IfEqual, hotkeyf5, 1, Run, "wmc_minimize.exe"
	IfEqual, pausekey, 1, Menu, Tray, Rename, Pause (Toggle) Hotkey's = 0ff, Pause (Toggle) Hotkey's = On
	IfEqual, pausekey, 1, Menu, Tray, Icon, Pause (Toggle) Hotkey's = On, ico_pause.ico
	IfWinExist, Windows Media Center,, goto, move
	IfExist, %windir%\ehome\ehshell.exe				;; check if WMC is installed
		{
			IfEqual, jump , 1, goto, skip
			IfEqual, autorun , 0, goto, skip
			IfGreater, t_UpTime, %timer%, goto, skip	;; Elapsed seconds since start if uptime upper variable timer sec start imediately
			sleep, %timer%000

			skip:
			SetEnv, jump, 0
			Menu, Tray, Icon, ico_red.ico
			run, "%windir%\ehome\ehshell.exe" %start%
			sleep, 500
			WinWait, Windows Media Center
			Menu, Tray, Icon, ico_red.ico
			sleep, 500
			IfEqual, minimize, 1, goto, minimize
			goto, move
		}
	else
		{
			Menu, Tray, Icon, ico_yellow.ico
			MsgBox, WMC not installed.
			goto, GuiClose2
		}

mousestart:
	SetEnv, jump, 1
	Goto, start

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
	WinMove, Windows Media Center, , 50, 0 , 1246
	WinActivate, Windows Media Center
	Goto, Run

	mon2-768:
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , %Mon2Left%, 0 , 1246
	WinMove, Windows Media Center, , %Mon2Left%, 0 , 1246
	WinActivate, Windows Media Center
	Goto, Run

	mon3-768:
	IfEqual, Mon3Bottom , 900, goto, mon3-900
	IfEqual, Mon3Bottom , 1050, goto, mon3-1050
	IfEqual, Mon3Bottom , 1080, goto, mon3-1080
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , %Mon3Left%, 0 , 1246
	WinMove, Windows Media Center, , %Mon3Left%, 0 , 1246
	WinActivate, Windows Media Center
	Goto, Run

900:
	IfEqual, gotomon ,2 , Goto, mon2-900
	IfEqual, gotomon ,3 , Goto, mon3-900
	WinMove, Windows Media Center, , 60, 0 , 1480
	WinActivate, Windows Media Center
	Goto, Run

	mon2-900:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , %Mon2Left%, 0 , 1480
	WinMove, Windows Media Center, , %Mon2Left%, 0 , 1480
	WinActivate, Windows Media Center
	Goto, Run

	mon3-900:
	IfEqual, Mon3Bottom , 768, goto, mon3-768
	IfEqual, Mon3Bottom , 1050, goto, mon3-1050
	IfEqual, Mon3Bottom , 1080, goto, mon3-1080
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , %Mon3Left%, 0 , 1480
	WinMove, Windows Media Center, , %Mon3Left%, 0 , 1480
	WinActivate, Windows Media Center
	Goto, Run

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
	IfEqual, gotomon ,3 , Goto, mon3-1050
	WinMove, Windows Media Center, , 0, 19 , 1680
	WinActivate, Windows Media Center
	Goto, Run

	mon2-1050:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1080, goto, mon2-1080
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , %Mon2Left%, 33 , 1680
	WinMove, Windows Media Center, , %Mon2Left%, 33 , 1680
	WinActivate, Windows Media Center
	Goto, Run

	mon3-1050:
	IfEqual, Mon3Bottom , 768, goto, mon3-768
	IfEqual, Mon3Bottom , 900, goto, mon3-900
	IfEqual, Mon3Bottom , 1080, goto, mon3-1080
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , %Mon3Left%, 33 , 1680
	WinMove, Windows Media Center, , %Mon3Left%, 33 , 1680
	WinActivate, Windows Media Center
	Goto, Run

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
	IfEqual, gotomon ,3 , Goto, mon3-1080
	WinMove, Windows Media Center, , 52, 0 , 1800
	WinActivate, Windows Media Center
	Goto, Run

	mon2-1080:
	IfEqual, Mon2Bottom , 768, goto, mon2-768
	IfEqual, Mon2Bottom , 900, goto, mon2-900
	IfEqual, Mon2Bottom , 1050, goto, mon2-1050
	Menu, Tray, Icon, ico_green.ico
	;; msgbox, Ecran 2 -- mon2Left=%Mon2Left% -- Top=%Mon2Top% -- Right=%Mon2Right% -- Bottom=%Mon2Bottom% -- gotomon=%gotomon% -- 1920x=%1920x%
	;; WinMove, Windows Media Center, , %Mon2Left%, 0 , 1800
	;; WinMove, WinTitle, WinText, X, Y, Width, Height
	SetEnv, 1920x, %Mon2Left%
	EnvAdd, 1920x, 30
	WinMove, Windows Media Center,, %1920x%, 0 , 1855,
	WinMove, Windows Media Center,, %1920x%, 0 , 1855,
	WinActivate, Windows Media Center
	Goto, Run

	mon3-1080:
	IfEqual, Mon3Bottom , 768, goto, mon3-768
	IfEqual, Mon3Bottom , 900, goto, mon3-900
	IfEqual, Mon3Bottom , 1050, goto, mon3-1050
	Menu, Tray, Icon, ico_green.ico
	;; msgbox, Ecran 2 -- mon2Left=%Mon2Left% -- Top=%Mon2Top% -- Right=%Mon2Right% -- Bottom=%Mon2Bottom% -- gotomon=%gotomon% -- 1920x=%1920x%
	;; WinMove, Windows Media Center, , %Mon2Left%, 0 , 1800
	;; WinMove, WinTitle, WinText, X, Y, Width, Height
	SetEnv, 1920x, %Mon3Left%
	EnvAdd, 1920x, 30
	WinMove, Windows Media Center,, %1920x%, 0 , 1855,
	WinMove, Windows Media Center,, %1920x%, 0 , 1855,
	WinActivate, Windows Media Center
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
	WinActivate, Windows Media Center
	Goto, Run

;--- Gui 2 start ---

	screenselecttray:
		Menu, Tray, Icon, ico_yellow.ico
		setenv oldvalue, %gotomon%

	screenselectgui2:
		Gui, Add, Edit, x5 y108 w358 h24 vEditgui2, %gotomon%
		Gui, Add, Button, x68 y137 w54 h24 , OK
		Gui, Add, Button, x247 y137 w54 h24 , Cancel
		Gui, Add, Text, x5 y5 w358 h98 , On witch monitor do you want to adjust WMC ?`n`t(3 monitor supported maximum)`nActual monitor:`t%gotomon%`nMonitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
		Gui, Add, Button, x50 y210 w75 h30 , Screen_1
		Gui, Add, Button, x150 y210 w75 h30 , Screen_2
		Gui, Add, Button, x250 y210 w75 h30 , Screen_3
		Gui, Add, Text, x28 y180 w330 h15 , Click on monitor you want WMC and move it immediately.
		Gui, Show, x1095 y420 h247 w372, %title%
		Return

	GuiClose:
	ButtonCancel:
		Gui, destroy
		goto, move

	ButtonOK:
		Gui, Submit, % Editgui2
		Gui, destroy
		IfEqual, oldvalue, %Editgui2%, Goto, screenselectgui2
		IfGreater, Editgui2, 2, Goto, screenselectgui2
		IfEqual, Editgui2, 0, Goto, screenselectgui2
		SetEnv, gotomon, %Editgui2%
		IniWrite, %Editgui2%, WMC fitscreen.ini, options, gotomon
		IfEqual, Editgui2, 1, SetEnv, gotomon, 1
		IfEqual, Editgui2, 2, SetEnv, gotomon, 2
		IfEqual, Editgui2, 3, SetEnv, gotomon, 3
		;IfEqual, Editgui2, 1, Menu, Tray, Rename, Screen Choice = %oldvalue%, Screen Choice = 1
		;IfEqual, Editgui2, 2, Menu, Tray, Rename, Screen Choice = %oldvalue%, Screen Choice = 2
		;IfEqual, Editgui2, 3, Menu, Tray, Rename, Screen Choice = %oldvalue%, Screen Choice = 3
		goto, ButtonCancel

	ButtonScreen_1:
		setenv, oldgotomon, %gotomon%
		Menu, Tray, Icon, ico_yellow.ico
		Gui, destroy
		IniWrite, 1, WMC fitscreen.ini, options, gotomon
		SetEnv, gotomon, 1
		;Menu, Tray, Rename, Screen Choice = %oldgotomon%, Screen Choice = 1
		goto, ButtonCancel

	ButtonScreen_2:
		IfEqual, Monitorcount, 1, Goto, ButtonCancel
		setenv, oldgotomon, %gotomon%
		Menu, Tray, Icon, ico_yellow.ico
		Gui, destroy
		IniWrite, 2, WMC fitscreen.ini, options, gotomon
		SetEnv, gotomon, 2
		;Menu, Tray, Rename, Screen Choice = %oldgotomon%, Screen Choice = 2
		goto, ButtonCancel

	ButtonScreen_3:
		IfEqual, Monitorcount, 2, Goto, ButtonCancel
		setenv, oldgotomon, %gotomon%
		Menu, Tray, Icon, ico_yellow.ico
		Gui, destroy
		IniWrite, 3, WMC fitscreen.ini, options, gotomon
		SetEnv, gotomon, 3
		;Menu, Tray, Rename, Screen Choice = %oldgotomon%, Screen Choice = 3
		goto, ButtonCancel

;--- Gui 2 end ---

minimize:
	Menu, Tray, Icon, ico_yellow.ico
	WinMinimize, Windows Media Center
	Sleep, 1000
	goto, run

maximize:
	Menu, Tray, Icon, ico_yellow.ico
	Winmaximize, Windows Media Center
	Sleep, 1000
	goto, run

openini:
	Menu, Tray, Icon, ico_yellow.ico
	run, notepad.exe "WMC fitscreen.ini"
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
	IniRead, timer, WMC fitscreen.ini, options, timer
	SetENv, oldtimer, %timer%
	InputBox, newtimer, WMC fitscreen, Set new timer start in seconds ? Now time is %timer% sec. Set between 1 and 240 seconds
		if ErrorLevel
			goto, run
	IniWrite, %newtimer%, WMC fitscreen.ini, options, timer
	;msgbox, old=%oldtimer%000 ... new=%newtimer%000
	IfGreater, newtimer, 240, Goto, Timerset
	IfLess, newtimer, 0, Goto, Timerset
	Menu, Tray, Rename, Start Timer = %oldtimer%, Start Timer = %newtimer%
	sleep, 500
	goto, run

pause:
	Menu, Tray, Icon, ico_yellow.ico
	IfEqual, pausekey, 1, goto, unpause
	IniWrite, 1, WMC fitscreen.ini, options, pausekey
	Menu, Tray, Icon, ico_green_pause.ico
	Menu, Tray, Rename, Pause (Toggle) Hotkey's = 0ff, Pause (Toggle) Hotkey's = On
	Menu, Tray, Icon, Pause (Toggle) Hotkey's = On, ico_pause.ico
	SetEnv, pausekey, 1
	Goto, Run

	unpause:
	Menu, Tray, Icon, Pause (Toggle) Hotkey's = On, ico_HotKeys.ico
	IniWrite, 0, WMC fitscreen.ini, options, pausekey
	Menu, Tray, Rename, Pause (Toggle) Hotkey's = On, Pause (Toggle) Hotkey's = 0ff
	Menu, Tray, Icon, ico_green.ico
	SetEnv, pausekey, 0
	Goto, Run

;;--- Quit (escape , esc) ---

GuiClose2:
	Process, Close, wmc_monitor1.exe
	Process, Close, wmc_monitor2.exe
	Process, Close, wmc_monitor3.exe
	Process, Close, wmc_minimize.exe
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, ico_yellow.ico
	IniRead, hotkeyf2, WMC fitscreen.ini, options, hotkeyf2
	IniRead, hotkeyf3, WMC fitscreen.ini, options, hotkeyf3
	IniRead, hotkeyf4, WMC fitscreen.ini, options, hotkeyf4
	IniRead, hotkeyf5, WMC fitscreen.ini, options, hotkeyf5
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2
	SysGet, Mon3, Monitor, 3
	MsgBox, 0, WMC Fit Screen, title=%title% mode=%mode% version=%version% author=%author% t_UpTime=%t_UpTime% A_WorkingDir=%A_WorkingDir%`n`nHotkey= F7=1 F2=%hotkeyf2% F3=%hotkeyf3% F4=%hotkeyf4% F5=%hotkeyf5%`n`nautorun=%autorun% timer=%timer% minimize=%minimize% fullscreen=%fullscreen% fullscreenstart=%fullscreenstart%`n`nstart=%start% %fullscreenstar2t%`n`ngotomon=%gotomon% MonitorCount=%MonitorCount% MonitorPrimary=%MonitorPrimary%`n`nMon 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%.`n`nMon 2 Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.`n`nMon 3 Left: %Mon3Left% -- Top: %Mon3Top% -- Right: %Mon3Right% -- Bottom %Mon3Bottom%.
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

autorunonoff:
	Menu, Tray, Icon, ico_red.ico
	IfEqual, autorun, 1, goto, disableautorun
	IfEqual, autorun, 0, goto, enableautorun
	msgbox, error_03 sound error
	Return

	enableautorun:
	Menu, Tray, Icon, ico_yellow.ico
	IniWrite, 1, WMC fitscreen.ini, options, autorun
	SetEnv, autorun, 1
	TrayTip, %title%, Autorun enabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 0, Autorun On/Off = 1
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

	disableautorun:
	Menu, Tray, Icon, ico_yellow.ico
	IniWrite, 0, WMC fitscreen.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 1, Autorun On/Off = 0
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	Return

mousesend:
	Menu, Tray, Icon, ico_red.ico
	run, "%windir%\ehome\ehshell.exe" %start% %fullscreenstart%
	sleep, 500
	WinWait, Windows Media Center
	sleep, 500
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
	goto, move

wmcclose:
	Menu, Tray, Icon, ico_red.ico
	sleep, 500
	WinClose, Windows Media Center
	sleep, 500
	goto, run

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

doReload:
	Menu, Tray, Icon, ico_yellow.ico
	Reload
	sleep, 500
	Return

fullscreen:
	Menu, Tray, Icon, ico_yellow.ico
	WinActivate, Windows Media Center
	sleep, 500
	send, !{enter}
	Menu, Tray, Icon, ico_green.ico
	IfEqual, pausekey, 1, Menu, Tray, Icon, ico_green_pause.ico
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