--"MoonNotify.lua"
--For use in MM (U) on BizHawk 1.9.1
--
--Addresses:
--0x3FF39A is Exit Setter
--0x1F331E is Entrance Setter
--0x1F35BA is Entrance Mod Setter
--0x1F0685 is Unknown BA

local addrs = {0x3FF39A,0x1F331E,0x1F35BA,0x1F0685}
local names = {"Exit Setter","Entrance Mod","Entrance Mod Setter","Unknown BA"}
local a = {} --addresses
local b = {} --frames
local c = {} --messages
local file = io.open("Lua/player/data/log.txt", "a")
local height = client.screenheight()

function handle(address,i,size)
	local current
	if size == 1 then
		current = memory.readbyte(address)
	else
		current = memory.read_u16_be(address)
	end
	if current ~= a[i] then
		local message = emu.framecount() ..": ".. names[i] .." changed from ".. a[i] .." to ".. current .."!"
		table.insert(b,emu.framecount())
		table.insert(c,message)
		file:write(message .."\n")
		file:flush()
		a[i] = current
	end
end

for i=1, 3, 1 do
	a[i] = memory.read_u16_be(addrs[i])
end
a[4] = memory.readbyte(addrs[4])

while true do
	gui.text(0,height-14,"Script On")
	if input.get().V == true then
		break
	end
	pic = emu.framecount()-180
	bn = table.getn(b)
	if bn > 0 then
		gui.drawImage("Lua/player/data/knuckles.jpg",300,380)
		for x=1, bn do
			if b[x] and pic > b[x] then
				table.remove(b,x)
				table.remove(c,x)
			else
				gui.text(0,128+14*x,c[x])
			end
		end
	end
	for i=1, 3, 1 do
		handle(addrs[i],i,2)
	end
	handle(addrs[4],4,1)
	emu.frameadvance()
end
file:close()