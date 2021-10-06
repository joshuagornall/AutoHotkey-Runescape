#include api/WindHumanMouse.ahk
#include api/random.ahk
#SingleInstance Force
return


; 14 keys
;G4  G4  D5  C5  A#4  A4  A4  A4  C5  A#4 A4  G4  G4  A#5  A5   G4  G4  A#5  A5  
;4, 4, 8, 7, 6, 5, 5 ,5, 7, 6, 5, 4, 4, 13,12, 4, 4, 13,12
;C D E F G A B C D E F  G  A  B
;0 1 2 3 4 5 6 7 8 9 10 11 12 13

1::
set_coord(leftX, leftY, "Left most key")
return

2::
set_coord(rightX, rightY, "Right most key")
return

3::
diffX := rightX - leftX
keyWidth := diffX/13
arr := [4, 4, 8, 7, 6, 5, 5 ,5, 7, 6, 5, 4, 4, 13,12, 4, 4, 13,12]
for index, element in arr ; Enumeration is the recommended approach in most cases.
{
	pressKey(element, keyWidth, leftX, leftY)
	Sleep, rand_range(500,700)
}
return

pressKey(pos, width, leftX, leftY) {
	xPos := pos*width + leftX
	sleep_click(xPos, leftY)
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