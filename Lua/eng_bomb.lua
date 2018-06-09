dofile("memory.lua")
console.clear()
linkHoldingPtr = 0x803ffed4
linkLastHeldPtr = 0
bombOff = 0x1F1
chuOff = 0x14B

function toHex(num)
    return string.format("%x",num)
end

function explosiveEntry(addr, off)
    list = {}
    list["addr"] = addr
    list["off"] = off
    return list
end

function getOffset(addr)
    if readByte(addr + 0x1) == 0x09 then
        return bombOff
    end
    return chuOff
end

explosives = {}
explosives[1] = explosiveEntry(0,0)
explosives[2] = explosiveEntry(0,0)
explosives[3] = explosiveEntry(0,0)

function checkLinksHands()
    actorPtr = bit.band(readWord(linkHoldingPtr),0x00FFFFFF)

    if actorPtr == 0 then
        linkLastHeldPtr = 0
        return
    end
    if actorPtr == linkLastHeldPtr then
        return
    end
    if readByte(actorPtr + 0x02) ~= 3 then
        return
    end

    if explosives[1]["addr"] == 0 then
        explosives[1] = explosiveEntry(actorPtr,getOffset(actorPtr))
    elseif explosives[2]["addr"] == 0 then
        explosives[2] = explosiveEntry(actorPtr,getOffset(actorPtr))
    else
        explosives[3] = explosiveEntry(actorPtr,getOffset(actorPtr))
    end

    linkLastHeldPtr = actorPtr

end

function updateHUD()
    x = 0
    y = 0
    spacing = 20
    for i=1,3 do
        addr = explosives[i]["addr"]
        if addr ~= 0 then
            off = explosives[i]["off"]
            timer = readByte(addr + off)
            type = ""
            if off == bombOff then
                type = "bomb"
            else
                type = "chu"
            end
            gui.drawString(x,y + i*spacing ,type .. " " .. timer)
            if timer == 0 then
                explosives[i]["addr"] = 0
                explosives[i]["off"] = 0
            end
        end
    end
end

while true do
    checkLinksHands()
    updateHUD()
    emu.frameadvance()
end
