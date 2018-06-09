-- "essposition.lua"
-- 'z' to ESS downleft, 'x' to ESS downright, 'c' to end

while true do
    result = input.get()
    if result.Z then
        joypad.setanalog({["X Axis"]=-15, ["Y Axis"]=-15}, 1)
    elseif result.X then
        joypad.setanalog({["X Axis"]=15, ["Y Axis"]=-15}, 1)
    elseif result.C then
        joypad.setanalog({["X Axis"]=0, ["Y Axis"]=0}, 1)
    end
    emu.frameadvance()
end
