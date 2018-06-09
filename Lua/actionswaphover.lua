--"actionswaphover.lua"
--For use in MM (U) on BizHawk 1.9.1
--Assumes shooty thing on c-down
--Addresses:
--Item in Hand  0x3FFEF8

while true do
	frame = 1
	while frame <= 45 do
		if frame <= 9 then
			joypad.setfrommnemonicstr("|..|    0,    0,.............d....|")
		else
			joypad.set({R=1},1)
		end
		if frame >= 22 and frame <= 24 then
			joypad.set({B=1},1)
		elseif frame >= 43 then
			joypad.set({A=1},1)
		end
		frame = frame + 1
		emu.frameadvance()
	end	
	emu.frameadvance()
end