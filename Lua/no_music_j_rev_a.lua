--"no_music.lua"
--For use in MM (J1.1) on BizHawk 1.9.1
--Addresses:
--0x2054E5 is BGM

while true do
    memory.writebyte(0x2054E5, 0xEF)
    emu.frameadvance()
end
