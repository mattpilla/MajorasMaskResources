--Name "heighthover.lua" (with quotes)
--For use in MM (U) on BizHawk 1.9.1
--Assumes bombs on c-left

local frame = 1
while frame <= 219 do
	if frame <= 9 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z.....ll.|")
	else
		joypad.setfrommnemonicstr("|..|    0, -127,.........Z......l.|")
	end
	if frame >= 198 then
		joypad.set({R=1,A=1},1)
	end
	frame = frame + 1
	emu.frameadvance()
end