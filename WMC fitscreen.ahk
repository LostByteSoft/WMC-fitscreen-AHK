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

;;--- Softwares Variables ---

	SetEnv, title, WMC FitScreen
	SetEnv, mode, WMC Best Fit Screen : F7
	SetEnv, version, Version 2017-04-23
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	SetTitleMatchMode, Slow
	SetTitleMatchMode, 2
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper (Var timer specified in WMC fitscreen.ini) sec start imediately

	FileInstall, ico_running.ico, ico_running.ico, 0
	FileInstall, WMC fitscreen.ini, WMC fitscreen.ini, 0
	FileInstall, ico_loading.ico, ico_loading.ico, 0
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
	FileInstall, ico_mute.ico, ico_mute.ico, 0
	FileInstall, ico_1.ico, ico_1.ico, 0
	FileInstall, ico_2.ico, ico_2.ico, 0
	FileInstall, ico_volume_2.ico, ico_volume_2.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_HotKeys.ico, ico_HotKeys.ico, 0

	IniRead, autorun, WMC fitscreen.ini, options, autorun
	IniRead, timer, WMC fitscreen.ini, options, timer
	IniRead, start, WMC fitscreen.ini, options, start
	IniRead, minimize, WMC fitscreen.ini, options, minimize
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen
	IniRead, hotkeyf3, WMC fitscreen.ini, options, hotkeyf3
	IniRead, hotkeyf4, WMC fitscreen.ini, options, hotkeyf4
	IniRead, hotkeyf5, WMC fitscreen.ini, options, hotkeyf5
	IniRead, gotomon, WMC fitscreen.ini, options, gotomon

	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Mon1, Monitor, 1
	SysGet, Mon2, Monitor, 2

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= WMC FitScreen =--, about
	Menu, Tray, Icon, --= WMC FitScreen =--, ico_running.ico, 1
	menu, tray, add
	Menu, tray, add, Exit FitScreen, GuiClose2				; GuiClose exit program
	Menu, Tray, Icon, Exit FitScreen, ico_shut.ico
	Menu, tray, add, Refresh FitScreen, doReload				; Reload the script.
	Menu, Tray, Icon, Refresh FitScreen, ico_reboot.ico, 1
	menu, tray, add
	menu, tray, add, --= Options General =--, about
	Menu, tray, Disable, --= Options General =--
	Menu, tray, add, Autorun On/Off = %autorun%, autorunonoff		; autorun
	Menu, Tray, Icon, Autorun On/Off = %autorun%, ico_options.ico, 1
	Menu, tray, add, Fullscreen On/Off = %fullscreen%, fullscreenonoff
	Menu, Tray, Icon, Fullscreen On/Off = %fullscreen%, ico_options.ico, 1
	menu, tray, add, Start Timer = %timer%, timerset
	Menu, Tray, Icon, Start Timer = %timer%, ico_options.ico, 1
	Menu, tray, add, Open WMC fitscreen.ini, openini
	Menu, Tray, Icon, Open WMC fitscreen.ini, ico_options.ico, 1
	menu, tray, add, --= Options Monitor Select =--, about
	Menu, tray, Disable, --= Options Monitor Select =--
 	Menu, tray, add, Screen Choice = %gotomon%, screenselecttray		; select screen menu
	Menu, Tray, Icon, Screen Choice = %gotomon%, ico_monitor.ico, 1
	Menu, TwoTree, Add, Monitor 1 and move, ButtonScreen_1
	Menu, TwoTree, Icon, Monitor 1 and move, ico_monitor.ico
	Menu, TwoTree, Add, Monitor 2 and move, ButtonScreen_2
	Menu, TwoTree, Icon, Monitor 2 and move, ico_monitor.ico
	;menu, tray, add, Hotkey F3 move = %hotkeyf3%, hotkeyonoff
	;Menu, Tray, Icon, Hotkey F3 move = %hotkeyf3%, ico_HotKeys.ico, 1
	;menu, tray, add, Hotkey F4 move = %hotkeyf4%, hotkeyonoff
	;Menu, Tray, Icon, Hotkey F4 move = %hotkeyf4%, ico_HotKeys.ico, 1
	Menu, Tray, Add, Click select monitor, :TwoTree
	menu, tray, add
	Menu, ThreeTree, Add, --= Hotkey list =--, about
	;Menu, ThreeTree, Disable, --= Hotkey list =--
	;Menu, ThreeTree, Add, Ctrl+M = Go to music, about
	;Menu, ThreeTree, Add, Ctrl+I = Go to Pictures, about
	;Menu, ThreeTree, Add, Ctrl+E = Go to Videos, about
	;Menu, ThreeTree, Add, Ctrl+U = Change DVD subtitles, about
	;Menu, ThreeTree, Add, Ctrl+T = Go to Live TV, about
	;Menu, ThreeTree, Add, Ctrl+R = Record a TV show, about
	;Menu, ThreeTree, Add, F3 - Monitor 1, about
	;Menu, ThreeTree, Add, F4 - Monitor 2, about
	Menu, ThreeTree, Add, F7 - Move, about
	Menu, ThreeTree, Add, F8 - Mute, about
	Menu, ThreeTree, Add, F9/F10 = Volume Up/Volume Down, about
	Menu, tray, add, About - LostByteSoft, about				; Creates a new menu item.
	Menu, Tray, Icon, About - LostByteSoft, ico_about.ico, 1
	Menu, tray, add, %Version% , version					; About version
	Menu, Tray, Icon, %Version%, ico_about.ico, 1
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico, 1
	menu, tray, add
	Menu, Tray, Add, ---= Hotkey list =--, :ThreeTree
	;Menu, tray, add, Hotkey: F3 - Monitor 1, ButtonScreen_1
	;Menu, Tray, Icon, Hotkey: F3 - Monitor 1, ico_1.ico, 1
	;Menu, tray, add, Hotkey: F4 - Monitor 2, ButtonScreen_2
	;Menu, Tray, Icon, Hotkey: F4 - Monitor 2, ico_2.ico, 1
	Menu, tray, add, Hotkey: F7 - Move, mousesend
	Menu, Tray, Icon, Hotkey: F7 - Move, ico_wmc.ico, 1
	Menu, tray, add, Hotkey: F8 - Mute, mute
	Menu, Tray, Icon, Hotkey: F8 - Mute, ico_mute.ico, 1
	menu, tray, add
	Menu, tray, add, WMC Exit / Close, wmcclose				; Close or Exit WMC, useful when in nochrome mode
	Menu, Tray, Icon, WMC Exit / Close, ico_shut.ico
	Menu, tray, add, WMC Full Screen, fullscreen			; Fullscreen
	Menu, Tray, Icon, WMC Full Screen, ico_full.ico, 1
	Menu, tray, add, WMC Minimize, minimize					; minimize
	Menu, Tray, Icon, WMC minimize, ico_minimize.ico, 1
	Menu, tray, add, WMC Maximize, Maximize					; Maximize
	Menu, Tray, Icon, WMC Maximize, ico_Maximize.ico, 1
	menu, tray, add
	Menu, tray, add, Start / Adjust / F7, mousesend				; Run the script.
	Menu, Tray, Icon, Start / Adjust / F7, ico_wmc.ico, 1
	Menu, Tray, Tip, Windows Media Center FitScreen

;;--- Software start here ---

	IfEqual, Monitorcount, 1, IniWrite, 1, WMC fitscreen.ini, options, gotomon
	IfEqual, fullscreen , 1, SetEnv, fullscreenstart, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart,
	IfEqual, hotkeyf3, 1, Run, "wmc_monitor1.exe"
	IfEqual, hotkeyf4, 1, Run, "wmc_monitor2.exe"
	IfEqual, hotkeyf5, 1, Run, "wmc_minimize.exe"
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
			Menu, Tray, Icon, ico_green.ico
			sleep, 500
			IfEqual, minimize, 1, goto, minimize
			goto, move
		}
	else
		{	Menu, Tray, Icon, ico_running.ico
			MsgBox, WMC not installed.
			goto, GuiClose2
		}

run:
	Menu, Tray, Icon, ico_running.ico
	KeyWait, F7, D
	Menu, Tray, Icon, ico_loading.ico
	IfWinExist, Windows Media Center,, goto, move
	run, "%windir%\ehome\ehshell.exe" %start% %fullscreenstart%
	sleep, 500
	Menu, Tray, Icon, ico_green.ico
	WinWait, Windows Media Center
	sleep, 500
	WinActivate, Windows Media Center

move:
	Menu, Tray, Icon, ico_loading.ico
	IniRead, gotomon, WMC fitscreen.ini, options, gotomon
	IfEqual, Mon1Bottom , 768, goto, 768
	IfEqual, Mon1Bottom , 900, goto, 900
	IfEqual, Mon1Bottom , 1050, goto, 1050
	IfEqual, Mon1Bottom , 1080, goto, 1080
	;MsgBox, You screen is not supported. Goto Default values. It could be not best adjust. (Blocked to move)
	goto, Default

768:
	IfEqual, gotomon ,2 , Goto, mon2-768
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

900:
	IfEqual, gotomon ,2 , Goto, mon2-900
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

1050:
	IfEqual, gotomon ,2 , Goto, mon2-1050
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

1080:
	IfEqual, gotomon ,2 , Goto, mon2-1080
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
	Menu, Tray, Icon, ico_green.ico
	WinMove, Windows Media Center, , 50, 50 , %Var1%, ;;%Var3%
	WinActivate, Windows Media Center
	Goto, Run

;--- Gui 2 start ---

	screenselecttray:
		Menu, Tray, Icon, ico_green.ico
		setenv oldvalue, %gotomon%

	screenselectgui2:
		Gui, Add, Edit, x5 y108 w358 h24 vEditgui2, %gotomon%
		Gui, Add, Button, x68 y137 w54 h24 , OK
		Gui, Add, Button, x247 y137 w54 h24 , Cancel
		Gui, Add, Text, x5 y5 w358 h98 , On witch monitor do you want to adjust WMC ?`n`t(2 monitor supported maximum)`nActual monitor:`t%gotomon%`nMonitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
		Gui, Add, Button, x52 y210 w100 h30 , Screen_1
		Gui, Add, Button, x222 y210 w100 h30 , Screen_2
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
		IfEqual, Editgui2, 1, Menu, Tray, Rename, Screen Choice = 2, Screen Choice = 1
		IfEqual, Editgui2, 2, Menu, Tray, Rename, Screen Choice = 1, Screen Choice = 2
		IfEqual, gotomon, 1, Menu, TwoTree, Enable, Monitor 2 and move
		IfEqual, gotomon, 2, Menu, TwoTree, Enable, Monitor 1 and move
		goto, ButtonCancel

	ButtonScreen_1:
		Gui, destroy
		SetEnv, oldgotomon, %gotomon%
		Menu, Tray, Icon, ico_green.ico
		IfEqual, gotomon, 1, goto, run
		IniWrite, 1, WMC fitscreen.ini, options, gotomon
		SetEnv, gotomon, 1
		Menu, Tray, Rename, Screen Choice = %oldgotomon%, Screen Choice = 1
		goto, ButtonCancel

	ButtonScreen_2:
		Gui, destroy
		SetEnv, oldgotomon, %gotomon%
		Menu, Tray, Icon, ico_green.ico
		;IfEqual, MonitorCount, 1, Goto, onlyonemonitor
		IfEqual, gotomon, 2, goto, run
		IniWrite, 2, WMC fitscreen.ini, options, gotomon
		SetEnv, gotomon, 2
		Menu, Tray, Rename, Screen Choice = %oldgotomon%, Screen Choice = 2
		goto, ButtonCancel

;--- Gui 2 end ---

minimize:
	Menu, Tray, Icon, ico_green.ico
	WinMinimize, Windows Media Center
	Sleep, 1000
	goto, run

maximize:
	Menu, Tray, Icon, ico_green.ico
	Winmaximize, Windows Media Center
	Sleep, 1000
	goto, run

openini:
	Menu, Tray, Icon, ico_green.ico
	run, notepad.exe "WMC fitscreen.ini"
	Sleep, 1000
	goto, run

mute:
	Menu, Tray, Icon, ico_green.ico
	IfEqual, mute, 1, goto, unmute
	SetEnv, mute, 1
	Menu, Tray, Icon, Hotkey: F8 - Mute, ico_volume_2.ico, 1
	WinActivate, Windows Media Center
	send, {F8}
	sleep, 500
	goto, run

	Unmute:
	SetEnv, mute, 0
	Menu, Tray, Icon, Hotkey: F8 - Mute, ico_mute.ico, 1
	WinActivate, Windows Media Center
	send, {F8}
	sleep, 500
	goto, run

timerset:
	Menu, Tray, Icon, ico_green.ico
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

hotkeyonoff:
	Menu, Tray, Icon, ico_green.ico
	IniRead, hotkeyf3, WMC fitscreen.ini, options, hotkeyf3
	IfEqual, hotkeyf3, 1, goto, hotkeyoff
	IniWrite, 1, WMC fitscreen.ini, options, hotkeyf3
	IniWrite, 1, WMC fitscreen.ini, options, hotkeyf4
	Menu, Tray, Rename, Hotkey F3 move = 0, Hotkey F3 move = 1
	Menu, Tray, Rename, Hotkey F4 move = 0, Hotkey F4 move = 1
	Run, "WMC F3 send to mon 1.exe"
	Run, "WMC F4 send to mon 2.exe"
	TrayTip, %title%, Hotkey Enabled = 1, 2, 2
	sleep, 500
	goto, run
	hotkeyoff:
	IniWrite, 0, WMC fitscreen.ini, options, hotkeyf3
	IniWrite, 0, WMC fitscreen.ini, options, hotkeyf4
	Process, Close, WMC F4 send to mon 2.exe
	Process, Close, WMC F3 send to mon 1.exe
	Menu, Tray, Rename, Hotkey F3 move = 1, Hotkey F3 move = 0
	Menu, Tray, Rename, Hotkey F4 move = 1, Hotkey F4 move = 0
	TrayTip, %title%, Hotkey Disabled = 0, 2, 2
	sleep, 500
	goto, run

;;--- Quit (escape , esc) ---

GuiClose2:
	Process, Close, WMC F4 send to mon 2.exe
	Process, Close, WMC F3 send to mon 1.exe
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, ico_loading.ico
	IfEqual, fullscreen , 1, SetEnv, fullscreenstart2, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart, (disabled)
	MsgBox, 0, WMC Fit Screen, title=%title% mode=%mode% version=%version% author=%author%`n`nt_UpTime=%t_UpTime% Hotkey=F7 A_WorkingDir=%A_WorkingDir%`n`nautorun=%autorun% timer=%timer% minimize=%minimize%`n`nstart=%start% %fullscreenstar2t% fullscreen=%fullscreen% fullscreenstart=%fullscreenstart%`n`ngotomon=%gotomon% `n`nresolution1=%Mon1Bottom% resolution2=%Mon2Bottom%
	IniRead, fullscreen, WMC fitscreen.ini, options, fullscreen
	IfEqual, fullscreen , 1, SetEnv, fullscreenstart, /directmedia:general
	IfEqual, fullscreen , 0, SetEnv, fullscreenstart,
	Menu, Tray, Icon, ico_running.ico
	Return

fullscreenonoff:
	Menu, Tray, Icon, ico_loading.ico
	IfEqual, fullscreen, 1, goto, disablefullscreen
	IfEqual, fullscreen, 0, goto, enablefullscreen
	msgbox, error_04 fullscreen error fullscreen=%fullscreen%
	Menu, Tray, Icon, ico_running.ico
	Return

	enablefullscreen:
	Menu, Tray, Icon, ico_green.ico
	IniWrite, 1, WMC fitscreen.ini, options, fullscreen
	SetEnv, fullscreen, 1
	TrayTip, %title%, fullscreen enabled - %fullscreen%, 2, 2
	Menu, Tray, Rename, Fullscreen On/Off = 0, Fullscreen On/Off = 1
	Menu, Tray, Icon, ico_running.ico
	Return

	disablefullscreen:
	Menu, Tray, Icon, ico_green.ico
	IniWrite, 0, WMC fitscreen.ini, options, fullscreen
	SetEnv, fullscreen, 0
	TrayTip, %title%, fullscreen disabled - %fullscreen%, 2, 2
	Menu, Tray, Rename, Fullscreen On/Off = 1, Fullscreen On/Off = 0
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
	Menu, Tray, Rename, Autorun On/Off = 0, Autorun On/Off = 1
	Menu, Tray, Icon, ico_running.ico
	Return

	disableautorun:
	IniWrite, 0, WMC fitscreen.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 1, Autorun On/Off = 0
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

about:
	Menu, Tray, Icon, ico_loading.ico
	TrayTip, %title%, %mode% by %author%, 2, 1
	Sleep, 500
	Menu, Tray, Icon, ico_running.ico
	Return

version:
	Menu, Tray, Icon, ico_loading.ico
	TrayTip, %title%, %version%, 2, 2
	Sleep, 500
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
;		     NO FUCKING WARRANTY AT ALL
;
;      The warranty is included in your anus. Look carefully you
;             might miss all theses small characters.
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