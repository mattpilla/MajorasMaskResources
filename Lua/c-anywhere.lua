--"c-anywhere.lua"
--For use in MM (U) on BizHawk 1.9.1
--Addresses:
--0x1F3588 is c-buttons anywhere

while true do
	memory.write_u32_be(0x1F3588, 0)
	emu.frameadvance()
end