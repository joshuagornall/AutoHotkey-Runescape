#include api/WindHumanMouse.ahk
#include api/random.ahk
#SingleInstance Force

leftClick := True
itemX := 0
itemY :=0
return

1::
leftClick := False
MouseGetPos centerX, centerY
sleep_click(itemX, itemY)
return

2::
leftClick := True
sleep_click(itemX + rand_range(-5,5), itemY + rand_range(170,175))
MouseMove, %itemX%, %itemY%, 50
return

4::
MouseGetPos itemX, itemY
set_coord(itemX, itemY, "item location")
return

sleep_click(x, y) {
	ToolTip
	BlockInput, MouseMove
	global leftClick
	x += target_random(-2,0,2)
	y += target_random(-2,0,2)
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