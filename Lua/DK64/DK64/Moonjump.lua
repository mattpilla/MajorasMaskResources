-- DK64 Moonjump BizHawk Lua port
-- Written by Isotarge, 2014-2015

-- Based on work by SubDrag, 2006
-- http://www.therwp.com/forums/showthread.php?t=7238

kong_model_pointer = 0x7fbb4d;

-- Relative to kong model
x_pos = 0x7c;
y_pos = 0x80;
z_pos = 0x84;

-- Keybinds
-- For full list go here http://slimdx.org/docs/html/T_SlimDX_DirectInput_Key.htm
decrease_precision_key = "Comma";
increase_precision_key = "Period";
reset_max_key = "Slash";

decrease_precision_pressed = false;
increase_precision_pressed = false;
reset_max_pressed = false;

-- Stops garbage min/max dx/dy/dz values
firstframe = true;

-- Rounding precision
precision = 3;

x = 0.0;
y = 0.0;
z = 0.0;

dx = 0.0;
dy = 0.0;
dz = 0.0;
d = 0.0;

prev_x = 0.0;
prev_y = 0.0;
prev_z = 0.0;

max_dx = 0.0;
max_dy = 0.0;
max_dz = 0.0;
max_d = 0.0;

function round(num, idp)
	return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function gofast (rel_pointer, speed)
	local kong_model = mainmemory.read_u24_be(kong_model_pointer);
	local pos = mainmemory.readfloat(kong_model + rel_pointer, true);
	mainmemory.writefloat(kong_model + rel_pointer, pos + speed, true);
end

function mainloop ()
	joypad_pressed = joypad.getimmediate();
	if joypad_pressed["P1 L"] then
		gofast(y_pos, 15.0);
	end
	if joypad_pressed["P1 DPad U"] then
		gofast(z_pos, 15.0);
	end
	if joypad_pressed["P1 DPad D"] then
		gofast(z_pos, -15.0);
	end
	if joypad_pressed["P1 DPad L"] then
		gofast(x_pos, 15.0);
	end
	if joypad_pressed["P1 DPad R"] then
		gofast(x_pos, -15.0);
	end
end

function handle_input ()
	input_table = input.get();

	-- Hold down key prevention
	if input_table[decrease_precision_key] == nil then
		decrease_precision_pressed = false;
	end

	if input_table[increase_precision_key] == nil then
		increase_precision_pressed = false;
	end

	if input_table[reset_max_key] == nil then
		reset_max_pressed = false;
	end

	-- Check for key presses
	if input_table[decrease_precision_key] == true and decrease_precision_pressed == false then
		precision = math.max(0, precision - 1);
		decrease_precision_pressed = true;
	end

	if input_table[increase_precision_key] == true and increase_precision_pressed == false then
		precision = math.min(15, precision + 1);
		increase_precision_pressed = true;
	end

	if input_table[reset_max_key] == true and reset_max_pressed == false then
		max_dx = 0.0;
		max_dy = 0.0;
		max_dz = 0.0;
		max_d = 0.0;
		reset_max_pressed = true;
	end
end

function plot_pos ()
	local kong_model = mainmemory.read_u24_be(kong_model_pointer);

	x = mainmemory.readfloat(kong_model + x_pos, true);
	y = mainmemory.readfloat(kong_model + y_pos, true);
	z = mainmemory.readfloat(kong_model + z_pos, true);

	if firstframe then
		prev_x = x;
		prev_y = y;
		prev_z = z;

		firstframe = false;
	end

	if emu.islagged() == false then
		dx = x - prev_x;
		dy = y - prev_y;
		dz = z - prev_z;
		d = math.sqrt(dx*dx + dy*dy + dz*dz);

		if math.abs(dx) > max_dx then max_dx = math.abs(dx) end
		if math.abs(dy) > max_dy then max_dy = math.abs(dy) end
		if math.abs(dz) > max_dz then max_dz = math.abs(dz) end
		if d > max_d then max_d = d end

		prev_x = x;
		prev_y = y;
		prev_z = z;
	end
	
	gui_x = 32;
	gui_y = 32;
	row = 0;
	
	height = 16;

	-- X, Y, Z
	gui.text(gui_x, gui_y + height * row, "X: "..round(x, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "Y: "..round(y, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "Z: "..round(z, precision));
	row = row + 2;

	-- dx, dy, dz
	gui.text(gui_x, gui_y + height * row, "dx: "..round(dx, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "dy: "..round(dy, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "dz: "..round(dz, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "d : "..round(d, precision));
	row = row + 2;

	-- Maximum dx, dy, dz, d
	gui.text(gui_x, gui_y + height * row, "Max dx: "..round(max_dx, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "Max dy: "..round(max_dy, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "Max dz: "..round(max_dz, precision));
	row = row + 1;
	gui.text(gui_x, gui_y + height * row, "Max d : "..round(max_d, precision));
end

event.oninputpoll(mainloop, "Moonjump");

event.onframestart(handle_input, "Keyboard input handler");
event.onframestart(plot_pos, "Plot position");