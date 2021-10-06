#include api/WindHumanMouse.ahk
#include api/random.ahk
#SingleInstance Force

itemColor := "0x3030B0"
objectColor := "0x90FF00"
return

1::
MouseGetPos centerX, centerY
click_color_radial(objectColor, centerX + rand_range(-30,30), centerY + rand_range(-30,30))
return

2::
shiftDrop(itemColor)
return

shiftDrop(color) {
	MouseGetPos centerX, centerY
	Send, {Shift down}
	loop, 4
	{
		click_color(color)
	}
	Send, {Shift up}
	Send, {Shift up}
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
	x += target_random(-7,0,7)
	y += target_random(-7,0,7)
	;MoveMouse(x, y)
	MouseMove, %x%, %y%, 50
	Sleep, rand_range(50,70)
	MouseClick, Left
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