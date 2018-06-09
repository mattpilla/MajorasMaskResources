--"avgtime.lua"
--For use in MM (J1.1) on BizHawk 1.9.1
--Measures frames starting from load state and ending on loading zone
--
--Addresses:
--0x09CE75 determines if loading zone has been entered

local zone
local switch = 1
local startframe
local runs = 0
local frames = 0
local total = 0
local avg = 0
local best = 99999999999
local height = client.screenheight()
function startCount()
	if switch == 1 then
		startframe = emu.framecount()
		switch = 0
	end
end

while true do
	zone = memory.readbyte(0x09CE75)
	if switch == 0 and zone ~= 63 then
		frames = emu.framecount() - startframe
		if frames < best then
			best = frames
		end
		total = total + frames
		runs = runs + 1
		avg = math.floor(total/runs)
		switch = 1
	end
	event.onloadstate(startCount)
	gui.text(0,height-14*5,"Frames: "..frames)
	gui.text(0,height-14*4,"Runs: "..runs)
	gui.text(0,height-14*3,"Average: "..avg)
	if best < 99999999999 then
		gui.text(0,height-14*2,"Best: "..best)
	end
	emu.frameadvance()
end