--"pausebuffer-revA.lua"
--For use in MM (J1.1) on BizHawk 1.9.1
--
--Addresses:
--0x1FA0F0 is Visual Frame
--0x3FD8CB is A Button

local frame = 0x1FA3A0
local a = 0x3FDB8B
local buffer = false

while true do
	if memory.readbyte(a) ~= lastA and lastA == 21 then
		x = emu.framecount() + 20
		buffer = true
	elseif buffer and emu.framecount() > x and memory.read_u32_be(frame) > lastFrame then
		joypad.set({Start=1},1)
		buffer = false
	end
	lastA = memory.readbyte(a)
	lastFrame = memory.read_u32_be(frame)
	emu.frameadvance()
end