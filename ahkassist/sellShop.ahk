#include api/WindHumanMouse.ahk
#include api/random.ahk
#SingleInstance Force

leftClick := True
return

1::
MouseGetPos sellX, sellY
leftClick := False
sleep_click(sellX, sellY)
leftClick := True
sleep_click(sellX, sellY)
return

;2::
;set_coord(sellX, sellY, "Coin pouch location")
;return

sleep_click(x, y) {
	ToolTip
	BlockInput, MouseMove
	global leftClick
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