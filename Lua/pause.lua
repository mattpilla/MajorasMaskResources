-- "pause.lua"
-- pauses emu first frame you have control after unpause

-- Addresses
vFrameAddr = 0x1f9f80 -- visual frame

x = 0
flag = false

while true do
    vFramePrev = vFrame
    vFrame = memory.read_u32_be(vFrameAddr)
    x = x + 1
    if vFrame ~= vFramePrev then
        x = 0
        if flag then
            flag = false
            client.pause()
            return
        end
    end
    if x > 35 then
        flag = true
    end
    emu.frameadvance()
end
