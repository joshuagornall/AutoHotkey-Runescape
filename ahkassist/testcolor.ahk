#SingleInstance Force
#persistent
rockItemColor := "0xFFFFFF"
Settimer getState, 1000
return
getState:
MouseGetPos mouseX, mouseY
PixelGetColor mouseColor, %mouseX%, %mouseY%
If (mouseColor = rockItemColor) {
	ToolTip, "yes"
	SetTimer, RemoveToolTip, -5000
}
return

RemoveToolTip:
Tooltip
return