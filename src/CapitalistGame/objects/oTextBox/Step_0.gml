var mouse_gx = device_mouse_x_to_gui(0);
var mouse_gy = device_mouse_y_to_gui(0);
var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

mouse_hover = false;
if(point_in_rectangle(mouse_gx, mouse_gy, x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y))
{
	mouse_hover = true;
}

if(mouse_check_button_pressed(mb_left))
{
	var was_active = can_write;
	can_write = false;
	keyboard_string = "";
	if(mouse_hover)
	{
		keyboard_string = text;
		can_write = true;
		if(time_source_get_state(ts_flash) != time_source_state_active)
		{
			time_source_start(ts_flash);
		}
	}
	if(was_active && !can_write)
	{
		enter_action();
		if(time_source_get_state(ts_flash) == time_source_state_active)
		{
			time_source_stop(ts_flash);
		}
	}
}

if(keyboard_lastkey == vk_enter)
{
	keyboard_lastkey = vk_nokey;
	can_write = false;
	enter_action();
	if(time_source_get_state(ts_flash) == time_source_state_active)
	{
		time_source_stop(ts_flash);
	}
}

if(can_write)
{
	text = keyboard_string;
}