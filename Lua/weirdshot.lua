--Name "weirdshot.lua" (with quotes)
--For use in MM (U) on BizHawk 1.9.1
--Gives first frame weirdshot
--Assumes you are human, have bomb bag, and can use bombs in the area
--Place the item you want to weirdshot with on c-right. If a valid item isn't there, hookshot is placed on c-right.
--Adds 1 to your bomb count and temporarily puts bombs on c-left if they weren't there already. C-left is then replaced back with what was there before the script was ran.
--Can't guarantee this will always work due to space, slopes, enemies, or lag. This was tested on flat, open surfaces.
--Addresses:
--c-left  0x1EF6BD
--c-right 0x1EF6BF
--bomb count 0x1EF716

local cleft = memory.readbyte(0x1EF6BD)
local cright = memory.readbyte(0x1EF6BF)

memory.writebyte(0x1EF716, memory.readbyte(0x1EF716)+1)
if  cleft ~= 6 then
	memory.writebyte(0x1EF6BD, 6)
end
if  cright ~= 15 and cright ~= 1 and cright ~= 74 and cright ~= 75 and cright ~= 76 then
	memory.writebyte(0x1EF6BF, 15)	
end

emu.frameadvance()

local frame = 1
while frame <= 234 do
	if frame <= 21 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z.....ll.|")
	elseif frame <= 33 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z......l.|")
	elseif frame <= 36 then
		joypad.setfrommnemonicstr("|..|  127, -128,.........Z......lr|")
	elseif frame <= 81 then
		joypad.setfrommnemonicstr("|..|  127, -128,.........Z......l.|")
	elseif frame <= 96 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z....r.lr|")
	elseif frame >= 178 and frame <= 180 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z.A....l.|")
	elseif frame <= 186 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z......l.|")
	elseif frame <= 222 then
		joypad.setfrommnemonicstr("|..| -128, -128,.........Z......l.|")
	else
		joypad.setfrommnemonicstr("|..| -128, -128,.........Z....r.l.|")
	end
	frame = frame + 1
	emu.frameadvance()
end
memory.writebyte(0x1EF6BD, cleft)