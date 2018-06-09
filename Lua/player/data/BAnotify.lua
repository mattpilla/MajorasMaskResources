--"BAnotify.lua"
--For use in MM (J) on BizHawk 1.9.1
--Starting Address Block 1: 0x1F35A8
--Ending Address Block 1: 0x1F37B7
--Starting Address Block 2: 0x1F3DA0
--Ending Address Block 2: 0x1F3E37

print(1)
local add = 0x1F35A8
local a = {} --bytes
local b = {} --frames
local c = {} --messages
local d = {107,113,121,127,338,339,340,341,342,343,344,349,351,353,355,357,359,369,375,396,398,399,400,406,407} --ignored frames
local file = io.open("Lua/player/data/log.txt", "a")

function handle(i)
	skip = 0
	for j=0,table.getn(d) do
		if i == d[j] then
			skip = 1
			break
		end
	end
	if skip == 0 and memory.readbyte(add + i) ~= a[i] then
		local message = emu.framecount() ..": Byte ".. bizstring.hex(add + i) .." changed from ".. a[i] .." to ".. memory.readbyte(add + i) .."!"
		table.insert(b,emu.framecount())
		table.insert(c,message)
		file:write(message .."\n")
		file:flush()
		a[i] = memory.readbyte(add + i)
	end
end

for i=0, 131 do
	a[i] = memory.readbyte(add+i)
end
for i=336,527 do
	a[i] = memory.readbyte(add+i)
end
for i = 2040,2191 do
	a[i] = memory.readbyte(add+i)
end

while true do
	gui.text(0,50,"Script On")
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
				gui.text(0,70+20*x,c[x])
			end
		end
	end
	for i=0,131 do
		handle(i)
	end
	for i=336,527 do
		handle(i)
	end
	for i = 2040,2191 do
		handle(i)
	end
	emu.frameadvance()
end
file:close()
print(0)