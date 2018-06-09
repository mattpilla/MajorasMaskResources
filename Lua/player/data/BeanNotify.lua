--"BeanNotify.lua"
--For use in MM (J) on BizHawk 1.9.1
--
--Addresses:
--0x3E8B4B is bean plant (16 to 208)
--0x471903 is 1 when planted, 0 otherwise

print(1)
local add1 = 0x3E8B4B
local add2 = 0x471903
local a = {} --bytes
local b = {} --frames
local c = {} --messages
local file = io.open("Lua/player/data/log.txt", "a")

function handle(address,i)
	if memory.readbyte(address) ~= a[i] then
		local message = emu.framecount() ..": Byte ".. bizstring.hex(address) .." changed from ".. a[i] .." to ".. memory.readbyte(address) .."!"
		table.insert(b,emu.framecount())
		table.insert(c,message)
		file:write(message .."\n")
		file:flush()
		a[i] = memory.readbyte(address)
	end
end

a[0] = memory.readbyte(add1)
a[1] = memory.readbyte(add2)

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
	handle(add1,0)
	handle(add2,1)
	emu.frameadvance()
end
file:close()
print(0)