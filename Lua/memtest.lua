mainWindow = forms.newform(655, 800, "Mem Test")

--Name textbox
forms.label(mainWindow, "Name:", 5, 5, 50, 18)
nameTextBox = forms.textbox(mainWindow, "0", 60, 18, "NAME", 60, 5)

--Address textbox
forms.label(mainWindow, "0x", 28, 5, 105, 18)
addressTextBox = forms.textbox(mainWindow, "0", 20, 18, "HEX", 10, 5)

--Size dropdown
a = {
	"1 byte",
	"2 byte",
	"4 byte",
	"float"
}
sizeDropdown = forms.dropdown(mainWindow, a, 5, 28, 55, 20)

--Sign dropdown
a = {
	"signed",
	"unsigned"
}
signDropdown = forms.dropdown(mainWindow, a, 65, 28, 70, 20)