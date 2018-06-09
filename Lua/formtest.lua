MainWindow = forms.newform(655, 800, "Better RAM Watch")
LabelDirection = forms.label(MainWindow, "facing", 67, 31, 40, 20)
a = { }
a[0] = "1.Right"
a[1] = "2.Left"
DirectionDropdown = forms.dropdown(MainWindow, a, 10, 28, 57, 20)