--form.lua
--For use in MM (U) on BizHawk 1.9.1

local form = forms.newform(200, 300, "Test")


function cleft()
	joypad.setfrommnemonicstr("|..|    0,    0,...............l..|")
	emu.frameadvance()
end

--forms.button(form, "c-left", cleft, 10, 10, 100, 50)
forms.addclick(form, cleft)