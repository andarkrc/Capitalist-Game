var mouse_gx = device_mouse_x_to_gui(0);
var mouse_gy = device_mouse_y_to_gui(0);
var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

mouse_hover = false;
if(point_in_rectangle(mouse_gx, mouse_gy, x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y))
{
	mouse_hover = true;
}

if(mouse_check_button_pressed(mb_left) && mouse_hover)
{
	left_click_action();
}

active = false;
if (oGameHandler.board[property].owner == targeted_player)
{
	active = true;
}

added_to_trade = false;
with(oGameHandler)
{
	if (other.targeted_player == players[player_turn].id)
	{
		if (array_contains(trade_given_properties, other.property))
		{
			other.added_to_trade = true;
		}
	}
	else
	{
		if (array_contains(trade_recieved_properties, other.property))
		{
			other.added_to_trade = true;
		}
	}
}
