--"time.lua"
--For use in MM (U) on BizHawk 1.9.1
--Z to go back in time
--X to go forward in time
--C to toggle between normal rate of time and inverted rate of time
--Keep in mind that time is separate from day, trying to go back a day will instead take you forward one.
--
--Addresses:
--0x1EF684 determines if ISoT has been played
--0x1EF686 is Rate of Time

local rate = 1
local accel = 1.1
local cap = 300
local pastDir = 0
local default = memory.read_u16_be(0x1EF686)+1
local held = false
function ChooseRate(dir)
	if dir ~= pastDir then
		rate = 1
		pastDir = dir
	elseif rate < cap then
		rate = accel*rate
		if rate > cap then
			rate = cap
		end
	end
end

memory.write_u16_be(0x1EF684,65535) --ensures clock will be correct color
while true do
	if input.get().C == true then
		if not held then
			held = true
			default = default*-1
		end
	elseif held then
		held = false
	end
	if input.get().Z == true then
		ChooseRate(0)
		memory.write_u16_be(0x1EF686,-2-rate)
	elseif input.get().X == true then
		ChooseRate(1)
		memory.write_u16_be(0x1EF686,rate)
	else
		rate = 1
		memory.write_u16_be(0x1EF686,default-1)
	end
	emu.frameadvance()
end