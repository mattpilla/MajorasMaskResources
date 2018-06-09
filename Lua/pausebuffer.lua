--"pausebuffer.lua"
--For use in MM (J/U) on BizHawk 1.9.1
--
--Addresses:
--0x1FA0F0 is Visual Frame (J)
--0x3FD8CB is A Button (J)
--
--0x1F9F80 is Visual Frame (U)
--0x3FD71D is A Button (U)

local hash = gameinfo.getromhash()
local versions = {
    ['D6133ACE5AFAA0882CF214CF88DABA39E266C078'] = 'US10'
}
local version = versions[hash]
local JP = version ~= 'US10'

local frame
local a
if not JP then
    -- US 1.0
	frame = 0x1F9F80
	a = 0x3FD71D
else
	frame = 0x1FA0F0
	a = 0x3FD8CB
end
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