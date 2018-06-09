--Name "diagram.lua" (with quotes)
--For use in MM (U) on BizHawk 1.9.1
--x: 0x3FFDD4
--z: 0x3FFDDC

--gui.DrawNew("diagram")
local x1 = memory.readfloat(0x3FFDD4,1)
local x2 = x1
local z1 = memory.readfloat(0x3FFDDC,1)
local z2 = z1

while true do
	x1 = x2
	z1 = z2
	x2 = memory.readfloat(0x3FFDD4,1)
	z2 = memory.readfloat(0x3FFDDC,1)
	--gui.drawLine(x1,z1,x2,z2,0x000000)
	emu.frameadvance()
	gui.drawLine(0,0,100,100,0x000000)
end