--Name "weirdshot.lua" (with quotes)
--For use in MM (U) on BizHawk 1.8.1
--Gives first frame weirdshot
--Assumes you are human, have bomb bag, and can use bombs in the area
--Place the item you want to weirdshot with on c-right. If a valid item isn't there, hookshot is placed on c-right.
--Adds 1 to your bomb count and temporarily puts bombs on c-left if they weren't there already. C-left is then replaced back with what was there before the script was ran.
--Can't guarantee this will always work due to space, slopes, enemies, or lag. This was tested on flat, open surfaces.
--Addresses:
--c-left  0x1EF6BE
--c-right 0x1EF6BC
--bomb count 0x1EF715

local cleft = memory.readbyte(0x1EF6BE)
local cright = memory.readbyte(0x1EF6BC)

memory.writebyte(0x1EF715, memory.readbyte(0x1EF715)+1)
if  cleft ~= 6 then
	memory.writebyte(0x1EF6BE, 6)
end
if  cright ~= 15 and cright ~= 1 and cright ~= 74 and cright ~= 75 and cright ~= 76 then
	memory.writebyte(0x1EF6BC, 15)	
end
emu.frameadvance()

local frame = 1
while frame <= 229 do
	if frame == 1 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z.....ll.|")
	elseif frame <= 7 then
		joypad.setfrommnemonicstr("|..|   77,  -57,.D.R.....Z......l.|")
	elseif frame <= 10 then
		joypad.setfrommnemonicstr("|..|   75,  -65,.D.R.....Z......lr|")
	elseif frame <= 50 then
		joypad.setfrommnemonicstr("|..|   75,  -65,.D.R.....Z......l.|")
	elseif frame <= 63 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z....r.lr|")
	elseif frame <= 68 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z......lr|")
	elseif frame == 179 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z.A....l.|")
	elseif frame <= 195 then
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z......l.|")
	elseif frame <= 222 then
		joypad.setfrommnemonicstr("|..| -128,    0,.........Z......l.|")
	else
		joypad.setfrommnemonicstr("|..|    0,    0,.........Z....r.l.|")
	end
	frame = frame + 1
	emu.frameadvance()
end
memory.writebyte(0x1EF6BE, cleft)

 