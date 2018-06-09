--"speedvector.lua"
--For use in MM (U) on BizHawk 1.9.1

--Addresses:
local lAddr = 0x400880 --linear velocity
local yAddr = 0x3FFE18 --y velocity

while true do
	height = client.screenheight()
	ySpeed = memory.readfloat(yAddr, true)
	linSpeed = memory.readfloat(lAddr, true)
	totalSpeed = math.sqrt(math.pow(ySpeed, 2) + math.pow(linSpeed, 2))
	gui.text(0, height-48, "Linear Velocity: " .. linSpeed)
	gui.text(0, height-34, "Y-velocity: " .. ySpeed)
	gui.text(0, height-20, "Total Speed: " .. totalSpeed)
	emu.frameadvance()
end