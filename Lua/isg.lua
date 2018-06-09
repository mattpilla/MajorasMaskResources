--Name "isg.lua" (with quotes)
--For use in MM (U) on BizHawk 1.9.1
--Assumes bombs on c-left
--Addresses:
--Visual Frame  0x1F9F83

--local vi = memory.readbyte(0x1F9F83)
--while vi == memory.readbyte(0x1F9F83) do
--	emu.frameadvance()
--end

local frame = 1
while frame <= 45 do
	if frame <= 9 then
		joypad.setfrommnemonicstr("|..|    0,    0,...............l..|")
	else
		joypad.set({R=1},1)
	end
	if frame >= 22 and frame <= 24 then
		joypad.set({B=1},1)
	elseif frame >= 43 then
		joypad.set({A=1},1)
	end
	frame = frame + 1
	emu.frameadvance()
end	