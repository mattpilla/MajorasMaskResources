--"heartcount.lua"
--For use in MM (U) on BizHawk 1.9.1
--Addresses:
--0x1EF6A4 is heart container amount

while true do
    gui.text(0, client.screenheight() - 14, "Heart Containers: "..memory.read_s16_be(0x1EF6A4)/16)
    if input.get().X == true then
        memory.write_s16_be(0x1EF6A4, 3984)
    elseif input.get().Z == true then
        memory.write_s16_be(0x1EF6A4, 48)
    end
    emu.frameadvance()
end
