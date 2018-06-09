--"BAtimer.lua"
--For use in MM (U) on BizHawk 1.9.1
--
--Monitor behavior of the last few bytes of the timer used in BA

--Addresses:
time_5 = 0x9e5b4
time_6 = 0x9e5b5
time_7 = 0x9e5b6
time_8 = 0x9e5b7
--Globals:
readByte = mainmemory.readbyte

--Setup:
last5 = readByte(time_5)
last6 = readByte(time_6)
last7 = readByte(time_7)
last8 = readByte(time_8)
emu.frameadvance()
frame = 1
total = 0

while true do
    local t5 = readByte(time_5)
    local t6 = readByte(time_6)
    local t7 = readByte(time_7)
    local t8 = readByte(time_8)

    local diff5 = t5 - last5
    if (diff5 < 0) then
        diff5 = diff5 + 256
    end
    local diff6 = t6 - last6 + (diff5 * 256)
    local diff7 = t7 - last7 + (diff6 * 256)
    local diff8 = t8 - last8 + (diff7 * 256)
    total = total + diff8
    local avg = math.floor(total/frame)

    local msg = 'frame ' .. emu.framecount() .. '\n\ttime_5: '
        .. last5 .. ' -> ' .. t5 .. ' (+' .. diff5 .. ')\n\ttime_6: '
        .. last6 .. ' -> ' .. t6 .. ' (+' .. diff6 .. ')\n\ttime_7: '
        .. last7 .. ' -> ' .. t7 .. ' (+' .. diff7 .. ')\n\ttime_8: '
        .. last8 .. ' -> ' .. t8 .. ' (+' .. diff8 .. ')\naverage increase: '
        .. avg .. '\n\n'
    print(msg)

    last5 = t5
    last6 = t6
    last7 = t7
    last8 = t8
    frame = frame + 1
    emu.frameadvance()
end
