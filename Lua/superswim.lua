-- "superswim.lua"
-- For use in MM on BizHawk 1.9.1
-- 'z' to start sinking superswim, 'x' to end

flag = false
frame = 0
-- how many visual frames to hold A and B
a = 1
b = 1
total = (a + b) * 3
max = total - (a * 3)

while true do
    result = input.get()
    if result.Z then
        flag = true
        frame = 0
    elseif result.X then
        flag = false
    end
    if flag then
        if frame % total >= max then
            joypad.set({A=1}, 1)
        else
            joypad.set({B=1}, 1)
        end
        frame = frame + 1
    end
    emu.frameadvance()
end
