#include api/WindHumanMouse.ahk
#include api/random.ahk
#SingleInstance Force

leftClick := True
coinX := 0
coinY :=0
return

1::
stunned()
leftClick := False
MouseGetPos centerX, centerY
click_color_radial(0xff4d00, centerX, centerY)
return

2::
stunned()
leftClick := True
MouseGetPos centerX, centerY
sleep_click(centerX + rand_range(-20,20), centerY + rand_range(75,80))
return

3::
sleep_click(coinX, coinY)
return

4::
MouseGetPos coinX, coinY
set_coord(coinX, coinY, "Coin pouch location")
return

stunned() {
	PixelSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xFF00FF, 0, Fast RGB
	If (ErrorLevel = 0) {
		Sleep, rand_range(500,1000)
	}
}
click_color_radial(color, centerX, centerY, distance := 50) {
	Tooltip
	mainDistance := distance
	Loop, 20
	{
		if (rand_bool()) {
			PixelSearch, FoundX, FoundY, % centerX+distance, % centerY+distance, % centerX-distance, % centerY-distance, color, 0, Fast RGB
		} else {
			PixelSearch, FoundX, FoundY, % centerX-distance, % centerY-distance, % centerX+distance, % centerY+distance, color, 0, Fast RGB
		}
		If (ErrorLevel = 0) {
			if (click_color_pos(color, FoundX, FoundY)) {
				return True
			}
		}
		distance += mainDistance
	}
	return False
}

click_color(color) {
	Tooltip
	PixelSearch, FoundX, FoundY, 0, 0, % A_ScreenWidth, % A_ScreenHeight, color, 0, Fast RGB
	If (ErrorLevel = 0) {
		sleep_click(FoundX,FoundY)
		return True
	}
	return False
}

click_color_pos(color, x, y, retry := 2) {
	Tooltip
	Loop, % retry {
		MoveMouse(x, y)
		if (color_under_mouse(color)) {
			sleep_click(x, y)
			return True
		}
		MouseGetPos mouseX, mouseY
		PixelSearch, tempX, tempY, % mouseX-10, % mouseY-10, % mouseX+10, % mouseY+10, color, 0, Fast RGB
		If (ErrorLevel = 0) {
			sleep_click(tempX, tempY)
			return True
		}
	}
	return False
}

sleep_click(x, y) {
	ToolTip
	BlockInput, MouseMove
	global leftClick
	x += target_random(-7,0,7)
	y += target_random(-7,0,7)
	;MoveMouse(x, y)
	MouseMove, %x%, %y%, 50
	Sleep, rand_range(50,70)
	if (leftClick) {
		MouseClick, Left
	} else {
		MouseClick, Right
	}
	Sleep, rand_range(20,40)
	BlockInput, MouseMoveOff
}

color_under_mouse(color) {
	Tooltip
	MouseGetPos mouseX, mouseY
	PixelSearch, FoundX, FoundY, % mouseX-1, % mouseY-1, % mouseX+1, % mouseY+1, color, 0, Fast RGB
	return % ErrorLevel = 0
}

set_coord(ByRef x, ByRef y, text) {
	Tooltip
	MouseGetPos, x, y
	x += rand()
	y += rand()
	ToolTip, %text%`n%x%`n%y%,%x%,%y%
	SetTimer, RemoveToolTip, -5000
}

RemoveToolTip:
Tooltip
return