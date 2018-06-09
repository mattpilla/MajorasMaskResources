local skutullaCode1stByte = 0x1F0665;
local bombersCode1stByte = 0x1F066B;
local lotteryCode1stByte = 0x1F065F;

local xPosition = 0x3FFDD4;
local yPosition = 0x3FFDD8;
local zPosition = 0x3FFDDC;
local internalSpeed = 0x3FFE20;

local currentDay = 0x1EF68B;
local igTime = 0x1EF67C;

local oneSecond = 86400 / 65535; --Number of real seconds / IG seconds. FF FF (65535) is midnight
local firstLine = 110;
local spacing = 12;

local bombersCode = "";
local skulltullaCode = {};
local lotteryCodes = {};

--Init stuff. this can be called once
local function init()
	for i = 0, 5 do
		skulltullaCode[i] = memory.readbyte(skutullaCode1stByte + i);
	end
	
	bombersCode = "";
	for i = 0, 4 do
		bombersCode = string.format("%s%s", bombersCode, memory.readbyte(bombersCode1stByte + i));
	end
	
	local k = 0;
	for i = 0, 2 do
		lotteryCodes[i] = {};
		for j = 0, 2 do
			lotteryCodes[i][j] = memory.readbyte(lotteryCode1stByte + k);
			k = k + 1;
		end
		k = k + 1;
	end
end

--Display several codes
local function codes()
	local color = "white";
	local tab = "";
	local jumpCount = 0;
	
	gui.text(0, firstLine, string.format("Bombers Code: %s", bombersCode));	
	for i = 0, 5 do		
		tab = "";
		if skulltullaCode[i] == 0 then
			color = "red";
		elseif skulltullaCode[i] == 1 then
			color = "blue";
		elseif skulltullaCode[i] == 2 then
			color = "yellow"
		else
			color = "green";
		end

		if i > 0 then
			if math.abs(skulltullaCode[i - 1] - skulltullaCode[i]) > 1
			or (skulltullaCode[i] == 1 and skulltullaCode[i - 1] > 1)
			or (skulltullaCode[i] == 2 and skulltullaCode[i - 1] < 2) then
				tab = "-";
				jumpCount = jumpCount + 1;
			end
		else
			tab = "";
		end
		if i == 0 then
			
		end
		gui.text(250 + i * 20, firstLine + spacing, string.format("%s%i", tab, skulltullaCode[i]), _, color);
	end
	gui.text(0, firstLine + spacing, string.format("Skulltula Code (%s jumps):", jumpCount));
	local currentDayValue = memory.readbyte(currentDay);
	if currentDayValue == 1 or currentDayValue == 2 or currentDayValue == 3 then
		gui.text(0, firstLine + spacing * 2, string.format("Lottery code: %i%i%i", lotteryCodes[currentDayValue - 1][0], lotteryCodes[currentDayValue - 1][1], lotteryCodes[currentDayValue - 1][2]));
	end
end

--Display coords
local function coord()
	gui.text(0, firstLine, string.format("X-position: %.3f", memory.readfloat(xPosition, true)), _, _, "topright");
	gui.text(0, firstLine + spacing, string.format("Y-position: %.3f", memory.readfloat(yPosition, true)), _, _, "topright");
	gui.text(0, firstLine + spacing * 2, string.format("Z-position: %.3f", memory.readfloat(zPosition, true)), _, _, "topright");
end

local function speed()
	gui.text(0, firstLine + spacing * 3, string.format("Internal speed: %.3f", memory.readfloat(internalSpeed, true)), _, _, "topright");
end

--Display accurate IG clock
local function clockDisplay()
	local hour = math.floor(memory.read_u16_be(igTime) * oneSecond / 3600);
	local decimalMinutes = (memory.read_u16_be(igTime) * oneSecond / 3600) - hour;
	gui.text(250, 3, string.format("%02.0f:%02.0f:%02.0f (day %i)", hour, math.floor(decimalMinutes * 60), (decimalMinutes * 60 - math.floor(decimalMinutes * 60)) * 60, memory.readbyte(currentDay)), _, _, "bottomleft");
end

--General UI call
local function ui()
	--init();
	codes();
	coord();
	speed();
	clockDisplay();
end

init();

--Main loop
while true do
	--init();
	ui();
	emu.frameadvance();
end