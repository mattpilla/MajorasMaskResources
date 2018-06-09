-- DK64 - Unlock menus
-- Written by Isotarge, 2014

menu_flags = 0x7ed558;

r = 0x744548;
e = 0x744568;
--3419616E000005397A61650005397A61650001A47A61650000457A6165

function unlock_menus ()
	for byte=0,7 do
		mainmemory.write_u8(menu_flags + byte, 0xff);
	end
end

event.onframestart(unlock_menus, "Unlock Menus");