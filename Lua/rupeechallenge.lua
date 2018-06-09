--"rupeechallenge.lua"
--For use in MM (U) on BizHawk 1.9.1
--
--Sets linear velocity to rupee count every frame
--Goal: beat the game

local rupeeAddr = 0x1ef6aa
local speedAddr = 0x400880
local doorAddr = 0x40081c

while true do
	if memory.readbyte(doorAddr) ~=  32 then
		memory.writefloat(speedAddr, memory.read_s16_be(rupeeAddr), 1)
	end
	emu.frameadvance()
end