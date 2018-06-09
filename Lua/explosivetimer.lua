--[[
All of these functions should be self explanitory. They read and write
mainmemory using either the physical address or virtual address in
kernal segment 0 or 1 (since the low 3 bytes are the same for all 3).

That is to say, if the physical address is 0x00123456, then you can pass
0x00123456 (physical address), 0x80123456 (kernal segment 0),
or 0xA0123456 (kernal segment 1)
--]]


function readByte(addr)
    return mainmemory.readbyte(bit.band(addr,0x00FFFFFF))
end

function writeByte(addr,val)
    return mainmemory.writebyte(bit.band(addr,0x00FFFFFF),val)
end

--===================================================================

function readShort(addr)
    return mainmemory.read_s16_be(bit.band(addr,0x00FFFFFF))
end

function readS16(addr)
    return readShort(addr)
end

function writeShort(addr,val)
    return mainmemory.write_s16_be(bit.band(addr,0x00FFFFFF),val)
end

function writeS16(addr,val)
    return writeShort(addr)
end
---------
function readHWord(addr)
    return mainmemory.read_u16_be(bit.band(addr,0x00FFFFFF))
end

function readU16(addr)
    return readHWord(addr)
end

function writeHWord(addr)
    return mainmemory.write_u16_be(bit.band(addr,0x00FFFFFF), val)
end

function writeU16(addr,val)
    return writeHWord(addr,val)
end

--===================================================================

function readS24(addr)
    return mainmemory.read_s24_be(bit.band(addr,0x00FFFFFF))
end

function writeS24(addr,val)
    return mainmemory.write_s24_be(bit.band(addr,0x00FFFFFF), val)
end
---------
function readU24(addr)
    return mainmemory.read_u24_be(bit.band(addr,0x00FFFFFF))
end

function writeU24(addr,val)
    return mainmemory.write_u24_be(bit.band(addr,0x00FFFFFF), val)
end

--===================================================================

function readLong(addr)
    return mainmemory.read_s32_be(bit.band(addr,0x00FFFFFF))
end

function readS32(addr)
    return readLong(addr)
end

function writeLong(addr, val)
    return mainmemory.write_s32_be(bit.band(addr,0x00FFFFFF), val)
end

function writeS32(addr, val)
    return writeLong(addr, val)
end

---------

function readWord(addr)
    return mainmemory.read_u32_be(bit.band(addr,0x00FFFFFF))
end

function readU32(addr)
    return readWord(addr)
end

function writeWord(addr, val)
    return mainmemory.write_u32_be(bit.band(addr,0x00FFFFFF), val)
end

function writeU32(addr, val)
    return writeWord(addr, val)
end

--===================================================================
--Converts a segmented address (seg) to an addressable useable by the
--above function by providing a base. Would like to eventually expand
--it to be able to just take in the segmented address and have it
--look up the base
function segToAddr(base, seg)
    return base + readU24(seg + 1)
end



-- mzxrules 2018

console.clear()
game = 'mm'
last_held_actor = 0

local v =
{
	['oot'] = -- OoT NTSC 1.0
	{
		actor_next = 0x124,
		link = 0x1DAA30,
		link_holding = 0x1DAA30 + 0x39C,
		bomb_timer = 0x1E8,
		chu_id = 0xDA,
		chu_timer = 0x140,
		exp_cat = 0x1CA0D0 + (0x8 * 3)
	},
	['mm'] = -- MM U
	{
		actor_next = 0x12C,
		link = 0x3FFDB0,
		link_holding = 0x3FFDB0 + 0x124,
		bomb_timer = 0x1F0,
		chu_id = 0x6A,
		chu_timer = 0x14A,
		exp_cat = 0x3E87D0 + (0xC * 3)
	}
}

function toHex(num)
    return string.format("%x",num)
end

function toS24(addr)
	return bit.band(addr, 0xFFFFFF)
end

function isBombchu(actor)
	local actorId = readS16(actor)
	return actorId == v[game].chu_id
end

function getTimerOffset(actor)
	if isBombchu(actor) then
		return v[game].chu_timer
	end
	return v[game].bomb_timer
end

function getName(actor)
	if isBombchu(actor) then
		return "Chu "
	end
	if readU16(actor + 0x1C) == 0 then
		return "Bomb"
	end
	return "Expl"
end


function getExplosiveActors(next)
	local list = {}
	local list_total = 0
	local total = 0
	while next ~= 0 do
		next = toS24(next)
		total = total + 1
		if total > 40 then break end
		local t = readS16(next + getTimerOffset(next))
		local n = getName(next)
		list[total] = {addr = next, timer = t, name = n}
		next = readU32(next + v[game].actor_next)
	end
	list_total = total
	return list
end

while true do
	-- Update held actor
	local held_actor = readU32(v[game].link_holding)
	held_actor = toS24(held_actor)

	if held_actor ~= 0 and readByte(held_actor + 0x2) == 3 then
		last_held_actor = held_actor
	end
	local exp_cat = v[game].exp_cat
	local exp = readU32(exp_cat)
	exp = toS24(exp)


	local exp_actor_next = readU32(exp_cat+4)

	local list = getExplosiveActors(exp_actor_next)
	local spacing = 20
	local offset = spacing

	local x = 300
	local y = 0

	gui.text(x,y, 'Last Held: ' .. string.format('%08X',last_held_actor))
	for i = 1, #list, 1 do
		local l = list[i]
		gui.text(x,y + offset, string.format('%06X',l.addr) .. ": ".. l.name .." Timer ".. l.timer)
		offset = offset + spacing
	end

	emu.frameadvance();
end
