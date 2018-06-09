--"sosscriptJ.lua"
--For use in MM (J) on BizHawk 1.9.1
--Edit of Faschz's script
--
--Memory Address notes
--0x1EF462 is current map and scene
--0x3FD622 is Soar Behavior
--0x3FD8CB is A button
--0x3FD8DB is Return B button value (True or False)
--0x3FDC04 is current inventory screen
--0x3FDC40 is Song of Soaring value
--
--To operate script properly, play movie first then run the script
 
--STARTING POINT HERE
local sosValue = 0
local file = io.open("sos_j_log.txt", "a")
 
while sosValue<32768 and sosValue>-32769 do
  if input.get().V == true then
    break
  end
  savestate.loadslot(1)
  memory.write_s16_be(0x3FDC40, sosValue)
 
  local valueUsed = memory.read_s16_be(0x3FDC40)
 
 
--while loop allows movie to be played out
  while movie.mode() == ("PLAY") do
    emu.frameadvance()
  end
 
 
--if statements to check end result of Index Warp
  if memory.read_u16_be(0x1EF462) ~= 54336 then
    if memory.read_u16_be(0x1EF462) == 26800 then
      message = valueUsed.." warps to Great Bay Coast --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 27232 then
      message = valueUsed.." warps to Zora Cape --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 45616 then
      message = valueUsed.." warps to Snowhead --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 39552 then
      message = valueUsed.." warps to Mountain Village --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 55440 then
      message = valueUsed.." warps to South Clock Town --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 15936 then
      message = valueUsed.." warps to Milk Road --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 34368 then
      message = valueUsed.." warps to Woodfall --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 33952 then
      message = valueUsed.." warps to Southern Swamp --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 8256 then
      message = valueUsed.." warps to Ikana Canyon --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 43568 then
      message = valueUsed.." warps to Stone Tower --- ".. memory.read_u16_be(0x3FD622)
    elseif memory.read_u16_be(0x1EF462) == 7184 then
      message = valueUsed.." Song of time --- ".. memory.read_u16_be(0x3FD622)
    else
      local mapWarp = memory.read_u16_be(0x1EF462)
      message = valueUsed.." warps to "..mapWarp .." --- ".. memory.read_u16_be(0x3FD622)
    end
  elseif memory.read_u16_be(0x3FD8DB) == 1 then
    message = valueUsed.." Crash --- ".. memory.read_u16_be(0x3FD622)
  elseif memory.read_u16_be(0x3FD8CB) == 10 and memory.read_u16_be(0x3FDC04) == 1 then
    message = valueUsed.." Softlock --- ".. memory.read_u16_be(0x3FD622)
  else
    message = valueUsed.." unknown result --- ".. memory.read_u16_be(0x3FD622)
  end
  print(message)
  file:write(message .."\n")
  file:flush()
 
--DIRECTION OF SCRIPT HERE
  sosValue = sosValue + 1
  emu.frameadvance()
end