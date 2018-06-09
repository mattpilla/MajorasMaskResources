--"buffer.lua"
--For use in MM (J) on BizHawk 1.9.1
--
--Addresses:
--0x1FA0F0 is Visual Frame
--0x3FD8CB is A Button
--0x3FDC04 is Inventory Screen

held = false
manual = "false"
add1 = 0x1FA0F0
last1 = memory.read_u32_be(add1)
add2 = 0x3FD8CB
last2 = memory.readbyte(add2)
add3 = 0x3FDC04
last3 = memory.read_u16_be(add3)
x = emu.framecount()+1000
while true do
	gui.text(0,440,"Manual: "..manual)
	if input.get().C == true then
		if not held then
			held = true
			if manual == "false" then
				manual = "true"
			else
				manual = "false"
			end
		end
	elseif held then
		held = false
	end
	if memory.readbyte(add2) == 21 then
		if memory.read_u16_be(add3) ~= last3 then
			joypad.set({Start=1},1)
		end
	elseif memory.readbyte(add2) ~= 21 and last2 == 21 then
		x = emu.framecount()+20
	end
	if emu.framecount() > x and memory.read_u32_be(add1) > last1 then
		joypad.set({Start=1},1)
		x = x +1000
	end
	last1 = memory.read_u32_be(add1)
	last2 = memory.readbyte(add2)
	last3 = memory.read_u16_be(add3)
	emu.frameadvance()
end