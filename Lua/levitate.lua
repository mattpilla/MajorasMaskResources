--"levitate.lua"
--For use in MM (J/U) on BizHawk 1.9.1
--
--Addresses:
--0x3FFE18 is Y-velocity (U)
--0x400008 is Y-velocity (J)

local hash = gameinfo.getromhash()
local versions = {
    ['D6133ACE5AFAA0882CF214CF88DABA39E266C078'] = 'US10',
}
local version = versions[hash]
local JP = version ~= 'US10'

local add
if not JP then
    -- US 1.0
    add = 0x3FFE18
else
    add = 0x400008
end

while true do
	if input.get().C == true then
		memory.writefloat(add, 7.5, 1)
	end
	emu.frameadvance()
end