var players = oGameHandler.players;
var board = oGameHandler.board;
var xx = board[players[oGameHandler.player_turn-1].position].xx1;
var yy = board[players[oGameHandler.player_turn-1].position].yy1;

if(!oGameHandler.property_upgrade_active)
{
	if(oGameHandler.spaces_left == 0)
	{
		if(players[oGameHandler.player_turn-1].position == 1)
		{
			x = xx + 256;
			y = yy + 256;
			x_lookat = xx + 128;
			y_lookat = yy + 128;
		}

		if(players[oGameHandler.player_turn-1].position >= 2 && players[oGameHandler.player_turn-1].position <= 10)
		{
			x = xx + 64;
			y = yy + 256;
			x_lookat = xx + 64;
			y_lookat = yy + 128;
		}

		if(players[oGameHandler.player_turn-1].position == 11)
		{
			x = xx;
			y = yy + 256;
			x_lookat = xx + 128;
			y_lookat = yy + 128;
		}

		if(players[oGameHandler.player_turn-1].position >= 12 && players[oGameHandler.player_turn-1].position <= 20)
		{
			x = xx;
			y = yy + 64;
			x_lookat = xx + 128;
			y_lookat = yy + 64;
		}

		if(players[oGameHandler.player_turn-1].position == 21)
		{
			x = xx;
			y = yy;
			x_lookat = xx + 128;
			y_lookat = yy + 128;
		}

		if(players[oGameHandler.player_turn-1].position >= 22 && players[oGameHandler.player_turn-1].position <= 30)
		{
			x = xx + 64;
			y = yy;
			x_lookat = xx + 64;
			y_lookat = yy + 128;
		}

		if(players[oGameHandler.player_turn-1].position == 31)
		{
			x = xx + 256;
			y = yy;
			x_lookat = xx + 128;
			y_lookat = yy + 128;
		}

		if(players[oGameHandler.player_turn-1].position >= 32 && players[oGameHandler.player_turn-1].position <= 40)
		{
			x = xx + 256;
			y = yy + 64;
			x_lookat = xx + 128;
			y_lookat = yy + 64;
		}
	}
	else
	{
		xx = oGameHandler.player_current_x;
		yy = oGameHandler.player_current_y;
	
		if(xx >= board[1].xx1 && xx <= board[1].xx1 + 256)
		{
			if(yy >= board[1].yy1 && yy <= board[1].yy1 + 256)
			{
				x = board[1].xx1 + 256;
				y = board[1].yy1 + 256;
				x_lookat = board[1].xx1 + 128;
				y_lookat = board[1].yy1 + 128;
			}
		}
	
		if(xx >= board[10].xx1 && xx <= board[2].xx1 + 128)
		{
			if(yy >= board[1].yy1 && yy <= board[1].yy1 + 256)
			{
				x = xx;
				y = board[1].yy1 + 256;
				x_lookat = xx;
				y_lookat = board[1].yy1 + 128;
			}
		}
	
		if(xx >= board[11].xx1 && xx <= board[11].xx1 + 256)
		{
			if(yy >= board[11].yy1 && yy <= board[11].yy1 + 256)
			{
				x = board[11].xx1;
				y = board[11].yy1 + 256;
				x_lookat = board[11].xx1 + 128;
				y_lookat = board[11].yy1 + 128;
			}
		}
	
		if(xx >= board[12].xx1 && xx <= board[12].xx1+256)
		{
			if(yy >= board[20].yy1 && yy  <= board[12].yy1+128)
			{
				x = board[12].xx1;
				y = yy;
				x_lookat = board[12].xx1 + 128;
				y_lookat = yy;
			}
		}
	
		if(xx >= board[21].xx1 && xx <= board[21].xx1 + 256)
		{
			if(yy >= board[21].yy1 && yy <= board[21].yy1 + 256)
			{
				x = board[21].xx1;
				y = board[21].yy1;
				x_lookat = board[21].xx1 + 128;
				y_lookat = board[21].yy1 + 128;
			}
		}
	
		if(xx >= board[22].xx1 && xx <= board[30].xx1+128)
		{
			if(yy >= board[22].yy1 && yy <= board[22].yy1+256)
			{
				x = xx;
				y = board[22].yy1;
				x_lookat = xx;
				y_lookat = board[22].yy1 + 128;
			}
		}
	
		if(xx >= board[31].xx1 && xx <= board[31].xx1 + 256)
		{
			if(yy >= board[31].yy1 && yy <= board[31].yy1 + 256)
			{
				x = board[31].xx1 + 256;
				y = board[31].yy1;
				x_lookat = board[31].xx1 + 128;
				y_lookat = board[31].yy1 + 128;
			}
		}
	
		if(xx >= board[40].xx1 && xx <= board[40].xx1+256)
		{
			if(yy >= board[32].yy1 && yy <= board[40].yy1+128)
			{
				x = board[40].xx1+256;
				y = yy;
				x_lookat = board[40].xx1+128;
				y_lookat = yy;
			}
		}
	}
}
else
{
	xx = board[oGameHandler.property_upgrade_index].xx1;
	yy = board[oGameHandler.property_upgrade_index].yy1;
	if(oGameHandler.property_upgrade_index == 1)
	{
		x = xx + 256;
		y = yy + 256;
		x_lookat = xx + 128;
		y_lookat = yy + 128;
	}

	if(oGameHandler.property_upgrade_index >= 2 && oGameHandler.property_upgrade_index <= 10)
	{
		x = xx + 64;
		y = yy + 256;
		x_lookat = xx + 64;
		y_lookat = yy + 128;
	}

	if(oGameHandler.property_upgrade_index == 11)
	{
		x = xx;
		y = yy + 256;
		x_lookat = xx + 128;
		y_lookat = yy + 128;
	}

	if(oGameHandler.property_upgrade_index >= 12 && oGameHandler.property_upgrade_index <= 20)
	{
		x = xx;
		y = yy + 64;
		x_lookat = xx + 128;
		y_lookat = yy + 64;
	}

	if(oGameHandler.property_upgrade_index == 21)
	{
		x = xx;
		y = yy;
		x_lookat = xx + 128;
		y_lookat = yy + 128;
	}

	if(oGameHandler.property_upgrade_index >= 22 && oGameHandler.property_upgrade_index <= 30)
	{
		x = xx + 64;
		y = yy;
		x_lookat = xx + 64;
		y_lookat = yy + 128;
	}

	if(oGameHandler.property_upgrade_index == 31)
	{
		x = xx + 256;
		y = yy;
		x_lookat = xx + 128;
		y_lookat = yy + 128;
	}

	if(oGameHandler.property_upgrade_index >= 32 && oGameHandler.property_upgrade_index <= 40)
	{
		x = xx + 256;
		y = yy + 64;
		x_lookat = xx + 128;
		y_lookat = yy + 64;
	}
}

/*
if(global.connection_type == "server")
{
	var side_movement = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var fb_movement = keyboard_check(ord("W")) - keyboard_check(ord("S")); //forward, backwards
	var ud_movement = keyboard_check(ord("Q")) - keyboard_check(ord("E"));

	x = x + move_speed*side_movement*cos(yaw_rotation - pi/2) - move_speed*fb_movement*sin(yaw_rotation - pi/2);
	y = y - move_speed*side_movement*sin(yaw_rotation - pi/2) - move_speed*fb_movement*cos(yaw_rotation - pi/2);
	z = z + move_speed*ud_movement;


	var m_input_lr = -(window_mouse_get_x() - floor(window_get_width()/2))/100;
	var m_input_ud = -(window_mouse_get_y() - floor(window_get_height()/2))/100;

	window_mouse_set(window_get_width()/2, window_get_height()/2);
	yaw_rotation += m_input_lr;
	pitch_rotation += m_input_ud;
	pitch_rotation = clamp(pitch_rotation, -pi/2 + 0.01, pi/2 - 0.01);

	if(yaw_rotation >= 2*pi)
	{
		yaw_rotation -= 2*pi;
	}

	if(yaw_rotation <= -2*pi)
	{
		yaw_rotation += 2*pi;
	}
}
*/

