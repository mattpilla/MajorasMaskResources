--Name "hess.lua" (with quotes)
--For use in MM (U) on BizHawk 1.9.1
--Assumes bombs on c-left
--pulls bomb, assumes human input, then rolls at the end

local frame = 1
while frame <= 179 do
	if frame <= 3 then
		joypad.setfrommnemonicstr("|..|    0,    0,...............l..|")
	elseif frame >= 177 then
		joypad.set({Z=1,R=1,A=1},1)
	elseif frame >= 153 then
		joypad.setfrommnemonicstr("|..|    0, -127,.........Z......l.|")
	end
	frame = frame + 1
	emu.frameadvance()
end