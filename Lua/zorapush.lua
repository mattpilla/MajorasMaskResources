--"zorapush.lua"
--For use in MM (U) on BizHawk 1.9.1
--
--Addresses:
--0x3FFDD4 is X position
--0x3FFDDC is Z position

--local x = memory.readfloat(0x3FFDD4,1)
while true do
	memory.writefloat(0x3FFDD4,memory.readfloat(0x3FFDD4,1)+1.0,1)
	emu.frameadvance()
end