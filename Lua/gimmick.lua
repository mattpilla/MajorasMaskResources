--"gimmick.lua"
--For use in MM (U) on BizHawk 1.9.1
--Item list: http://bombch.us/BDlV

--Addresses:
rupees = 0x1ef6aa
--Addresses for displaying c icons
cleft = 0x3fd773
cright = 0x3fd775
cdown = 0x3fd777
--Addresses for items on c-buttons
leftitem = 0x1ef6bd
rightitem = 0x1ef6be
downitem = 0x1ef6bf
--Addresses for B items of each form
bhuman = 0x1ef6bc
bdeku = 0x1ef6c8
bgoron = 0x1ef6c0
bzora = 0x1ef6c4

--Globals:
readByte = memory.readbyte
writeByte = memory.writebyte
readShort = memory.read_s16_be
writeShort = memory.write_s16_be

while true do
    local item = readShort(rupees)
    if item > 255 then
        item = 255
    end
    --Set B items to rupee count
    writeByte(bhuman, item)
    writeByte(bdeku, item)
    writeByte(bgoron, item)
    writeByte(bzora, item)
    --Disable using C
    writeByte(leftitem, 255)
    writeByte(rightitem, 255)
    writeByte(downitem, 255)
    --Hide C icons
    writeByte(cleft, 0)
    writeByte(cright, 0)
    writeByte(cdown, 0)
    emu.frameadvance()
end
