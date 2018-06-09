-- DK64 - Refill Consumables
-- Written by Isotarge, 2014
-- Based on research by Exchord

-- Make some shorthand versions of BizHawk's memory functions
mrb = mainmemory.readbyte;
mwb = mainmemory.write_u8;
mru24 = mainmemory.read_u24_be;
mrf = mainmemory.readfloat;
mwf = mainmemory.writefloat;

-- Maximum values
max_melons = 4;
max_health = max_melons * 4;

max_coins          = 50;
max_crystals       = 20;
max_film           = 10;
max_oranges        = 20;
max_musical_energy = 10;
max_standard_ammo  = 50;
max_homing_ammo    = 50;

-- Global pointers
global_base = 0x7fcc41;

standard_ammo = 0;
homing_ammo   = 2;
oranges       = 4;
film          = 8;
health        = 10;
melons        = 11;

-- Kong index
DK     = 0;
Diddy  = 1;
Lanky  = 2;
Tiny   = 3;
Chunky = 4;

-- Base for Kong objects
kongbase = {
	[DK]     = 0x7fc950,
	[Diddy]  = 0x7fc9ae,
	[Lanky]  = 0x7fca0c,
	[Tiny]   = 0x7fca6a,
	[Chunky] = 0x7fcac8
};

-- Pointers relative to Kong base
moves      = 0;
sim_slam   = 1;
weapon     = 2;
instrument = 4;
coins      = 7;

function unlock_everything ()
	local kong;
	for kong=DK,Chunky do
		local base = kongbase[kong];
		mwb(base + moves,      3);
		mwb(base + sim_slam,   3);
		mwb(base + weapon,     7);
		mwb(base + instrument, 15);
		mwb(base + coins,      max_coins);
	end
end

function refill_pickups ()
	mwb(global_base + standard_ammo, max_standard_ammo);
	mwb(global_base + homing_ammo,   max_homing_ammo);
	mwb(global_base + oranges,       max_oranges);
	mwb(global_base + film,          max_film);
	mwb(global_base + health,        max_health);
	mwb(global_base + melons,        max_melons);
end

event.onframestart(refill_pickups, "Refill Consumables");
unlock_everything();