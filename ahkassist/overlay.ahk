#SingleInstance Force
;showText("fuck yeah", -2000)
return

showText(text) {
	GoSub hide_text
	Gui showTextOverlay: +LastFound +AlwaysOnTop -Caption +ToolWindow
	Gui showTextOverlay: Font, s50, Calibri
	GuiControl +BackgroundTrans, showTextOverlay
	Gui showTextOverlay: Add, Text, x0 y0, % text ;the text to display
	length := StrLen(text) * 30
	Gui showTextOverlay: Show, x0 y750 w%length% h100 NA, Test GUI Window
}
return

hide_text:
Gui showTextOverlay: Hide
return

marker(X:=0, Y:=0, W:=0, H:=0, guiColor := "Green")
{
	Gui marker: +LastFound +AlwaysOnTop -Caption +ToolWindow
	;Gui marker: +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x08000000 +E0x80020
	Gui marker: Color, %guiColor%
	Gui marker: Show, w%W% h%H% x%X% y%Y% NA

	WinSet, Transparent, 150
	WinSet, Region, 0-0 %W%-0 %W%-%H% 0-%H% 0-0
	Return
}