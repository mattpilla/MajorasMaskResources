--Name "zorahover.lua" (with quotes)
--For use in MM (U) on BizHawk 1.9.1
--'z' to autopunch, 'x' to stop

local result = input.get()

local frame = 1
local hover = 1
while true do
	result = input.get()
	if result.Z == true then
		hover = 1
		frame = 1
	elseif result.X == true then
		hover = 0
	end
	if hover == 1 and frame >= 1 and frame <= 3 then
		joypad.set({B=1},1)
	end
	frame = frame + 1
	if frame > 30 then
		frame = 1
	end
	emu.frameadvance()
end