-- "autobuffer.lua"
-- For use in MM (U) on BizHawk 1.9.1

-- Addresses:
buffer = 0x1f3595 -- unpause when 2, pause when 3
framerate = 0x3e6bc2 -- 2 during pause, 3 during normal gameplay
frame = 0x1f9f80 -- visual frame
x = 0 -- don't worry bout it

while true do
    paused = memory.readbyte(framerate) == 2
    value = memory.readbyte(buffer)
    if paused and value == 2 then
        joypad.set({Start=1}, 1)
    elseif not paused and x == 0 and value == 1 then
        x = memory.read_u32_be(frame)
    elseif not paused and x ~= 0 and memory.read_u32_be(frame) > x then
        x = 0
        joypad.set({Start=1}, 1)
    end
    emu.frameadvance()
end
