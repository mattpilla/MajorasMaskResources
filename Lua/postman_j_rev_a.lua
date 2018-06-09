--"postman_j_rev_a.lua"
--For use in MM (J1.1) on Bizhawk 1.9.1

--Addresses:
local postTimer = 0x1f37ac

while true do
    local currTime = memory.read_u32_be(postTimer)
    if currTime >= 995 and currTime < 1000 then
        print(currTime)
        joypad.set({A = 1}, 1)
    end
    emu.frameadvance()
end
