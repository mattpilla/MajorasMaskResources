--"readtime.lua"
--For use in MM (J/U) on BizHawk 1.9.1
--Displays in-game time numerically, like a digital clock
--Text placement assumes 640x480 resolution
--
--Addresses:
--0x1EF67C is Game Time (U)
--0x1EF46C is Game Time (J)

local hash = gameinfo.getromhash()
local versions = {
    ['D6133ACE5AFAA0882CF214CF88DABA39E266C078'] = 'US10'
}
local version = versions[hash]
local JP = version ~= 'US10'

local add
if not JP then
    -- US 1.0
    add = 0x1EF67C
else
    add = 0x1EF46C
end

function display(hr,mn)
	am = "pm"
	if hr > 12 then
		hr = hr-12
	elseif hr ~= 12 then
		if hr == 0 then
			hr = 12
		end
		am = "am"
	end
	if mn > 9 then
		gui.text(290,450,hr..":"..mn..am)
	else
		gui.text(290,450,hr..":0"..mn..am)
	end
end

while true do
	frame = memory.read_u16_be(add)
	hour = math.floor(3*frame/8192)
	remain = 3*frame/8192 - hour
	minute = math.floor(3*math.floor(remain*100)/5)
	display(hour,minute)
	emu.frameadvance()
end