-- mzxrules 2018
dofile("memory.lua")
console.clear()
game = 'oot'
last_held_actor = 0

local v = 
{
	['oot'] = -- OoT NTSC 1.0
	{
		actor_next = 0x124,
		link = 0x801DAA30,
		link_holding = 0x801DAA30 + 0x39C,
		bomb_timer = 0x1E8,
		chu_id = 0xDA,
		chu_timer = 0x140,
		exp_cat = 0x801CA0D0 + (0x8 * 3)
	},
	['mm'] = -- MM U
	{
		actor_next = 0x12C,
		link = 0x803FFDB0,
		link_holding = 0x803FFDB0 + 0x124,
		bomb_timer = 0x1F0,
		chu_id = 0x6A,
		chu_timer = 0x14A,
		exp_cat = 0x803E87D0 + (0xC * 3)
	}
}

function toHex(num)
    return string.format("%x",num)
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
	
	if held_actor ~= 0 and readByte(held_actor + 0x2) == 3 then
		last_held_actor = held_actor
	end
	local exp_cat = v[game].exp_cat
	local exp = readU32(exp_cat)
	local exp_actor_next = readU32(exp_cat+4)
	
	local list = getExplosiveActors(exp_actor_next)
	local spacing = 20
	local offset = spacing
	
	local x = 0
	local y = 0

	gui.text(x,y, 'Last Held: ' .. string.format('%08X',last_held_actor))
	for i = 1, #list, 1 do
		local l = list[i]
		gui.text(x,y + offset, string.format('%06X',l.addr) .. ": ".. l.name .." Timer ".. l.timer)
		offset = offset + spacing
	end

	emu.frameadvance();
end