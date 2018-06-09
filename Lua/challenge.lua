--"challenge.lua"
--For use in MM (U) on BizHawk 1.9.1
--TODO:
--Ban GIM
--Tie loseHeart function directly to the opening of door/chest
--Go to title on 0 hearts

--Addresses:
hearts = 0x1EF6A4 --Heart container amount
health = 0x1EF6A6 --HP
action = 0x3FD71D --A button action

--Globals:
readByte = memory.readbyte
readShort = memory.read_s16_be
writeShort = memory.write_s16_be
held = false --Was A held last frame?
lastAction = 0 --A button action on the last frame

function loseHeart()
    local heartCount = readShort(hearts) - 16
    writeShort(hearts, heartCount) --take away 1 heart
    writeShort(health, heartCount) --take away 1 heart of HP
    if (heartCount <= 0) then
        --TODO: go to title screen
    end
end

while true do
    local currentAction = readByte(action) --A button action on this frame
    local inputs = joypad.get(1) --All inputs on this frame
    if (lastAction == 4 and inputs['A'] and not held) then
        held = true --Limit to call once per A button hold
        loseHeart() --Activate when A is held with open on A
    end
    lastAction = currentAction
    held = inputs['A']
    emu.frameadvance()
end
