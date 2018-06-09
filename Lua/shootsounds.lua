--"shootsounds.lua"
--For use in MM (J) on BizHawk 1.9.1
--shoutouts to Faschz cuz I just edited his shit

--Memory Address notes
--0x4008D8 is lit stick timer
--0x1EF67C is game clock
--
--To operate script properly, play movie first then run the script
 
--STARTING POINT HERE
local litTimer = -1
local file = io.open("soundsminus.txt", "a")
 
while litTimer<32768 and litTimer>-32769 do
  savestate.loadslot(1)
  memory.write_s16_be(0x4008D8, litTimer)
 
  local valueUsed = memory.read_s16_be(0x4008D8)
 
 
--while loop allows movie to be played out
  while movie.mode() == ("PLAY") do
	memory.write_s16_be(0x4008D8, litTimer)
    emu.frameadvance()
  end
 
 
--if statements to check for softlock
  if memory.read_u16_be(0x1EF67C) < 37680 then
    print(valueUsed.." softlocks")
	file:write(valueUsed.." softlocks" .."\n")
	file:flush()
  else
    print(valueUsed.." works")
	file:write(valueUsed.." works" .."\n")
	file:flush()
  end
 
--DIRECTION OF SCRIPT HERE
  litTimer = litTimer - 1
  emu.frameadvance()
end
file:close()