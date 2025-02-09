#Persistent
#NoEnv
#SingleInstance, Force
;#IfWinActive, ahk_exe GTA5.exe
WinSet, AlwaysOnTop

SetWorkingDir, %A_ScriptDir%

Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
Gui, Color, cGrey
Gui, Font, s20 cWhite, Arial
Gui, add, Picture, w200 h200,ggw.png
Gui, Add, Text, vTimerText w90 h50 x90 y100, Start
Gui, Show, x900 y0 NoActivate, Timer

return

Floor = false

~E::
    if (!TimerRunning) {
		if(!Floor){
			TimerRunning := true
			SetTimer, UpdateTimer, 1000
			TimeLeft := 68 ; 1 min 08 sec
				Gosub, UpdateTimer
		}

		else if (Floor){
			TimerRunning := true
			SetTimer, UpdateTimer, 1000
			TimeLeft := 88 ; 1 min 28 sec
			Gosub, UpdateTimer
		}
		}

return

~F::
    if (!TimerRunning) {
		if (Floor){
			Floor := false
			TimerText := "Floor 1"
			GuiControl,, TimerText, % TimerText
		}

		else if (!Floor){
			Floor := true
			TimerText := "Floor 2"
			GuiControl,, TimerText, % TimerText
		}
	}

return

~R::
	if (TimerRunning) {
		TimerRunning := false
		SetTimer, UpdateTimer, Off
		TimerText := "Restart"
		GuiControl,, TimerText, % TimerText
	}

return


~C::
	ExitApp

return

UpdateTimer:
    TimeLeft--
    Minutes := Floor(TimeLeft / 60)
    Seconds := Mod(TimeLeft, 60)
    TimerText := Format("{:02}:{:02}", Minutes, Seconds)
    GuiControl,, TimerText, % TimerText
    if (TimeLeft <= 0)
    {
        SetTimer, UpdateTimer, Off
        SoundPlay, ring.mp3
    }
	if (TimeLeft <= 5){
		SoundPlay, ring.mp3
	}
return