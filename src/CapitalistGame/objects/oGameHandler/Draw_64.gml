var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

drawSetup(,,, fa_left);

if(game_started == false)
{
	var xx = display_get_gui_width()/2 - 144*array_length(players)/2 + 8;
	var yy = display_get_gui_height()/2 - 48;
	for(var i = 0; i < array_length(players); i++)
	{
		drawSetup(c_white, 0.8);
		draw_rectangle(xx*ratio_x, yy*ratio_y, (xx+128)*ratio_x, (yy+128)*ratio_y, false);
		drawSetup(players[i].color, 1);
		draw_text_transformed(xx+64, yy-16, players[i].name, ratio_x, ratio_y, 0);
		draw_sprite_stretched(asset_get_index($"sPiece{players[i].piece}"), 0, xx*ratio_x, yy*ratio_y, 128*ratio_x, 128*ratio_y);
		
		if(players[i].ready)
		{
			drawSetup(c_green, 1);
			draw_text_transformed(xx+64, yy+144, "Ready", ratio_x, ratio_y, 0);
		}
		else if(!players[i].ready)
		{
			drawSetup(#B00000, 1);
			draw_text_transformed(xx+64, yy+144, "Not Ready", ratio_x, ratio_y, 0);
		}
		xx += 144;
	}
	
	if(game_starting)
	{
		drawSetup(c_red);
		draw_text_transformed(room_width/2*ratio_x, room_height/10*ratio_y, $"Game starting in {game_starting_counter} ...", ratio_x, ratio_y, 0);
	}
}
else if(game_started)
{
	drawSetup(,,,fa_left);
	draw_text(16, 16, $"MY ID : {my_player_id} -- TURN ID : {players[player_turn-1].id}");
	//draw_line(display_get_gui_width()/2, 0, display_get_gui_width()/2, display_get_gui_height());
	
	var xx = display_get_gui_width()/2 - 144*array_length(players)/2 + 8;
	var yy = display_get_gui_height() - 160;
	for(var i = 0; i < array_length(players); i++)
	{
		drawSetup(c_ltgray, 0.8);
		draw_rectangle(xx, yy, (xx+64), (yy+64), false);
		drawSetup(players[i].color, 1);
		var nw = string_width(players[i].name);
		var nh = string_height(players[i].name);
		var mw = string_width($"${players[i].money}");
		var mh = string_height($"${players[i].money}");
		drawSetup(c_white, 0.7);
		draw_rectangle(xx+32 - nw/2, yy-nh-mh-nh/2-2, xx+32 + nw/2, yy-nh-mh+nh/2-2, false);
		drawSetup(players[i].color, 1);
		draw_text_transformed(xx+32, yy-nh-mh-1, players[i].name, 1, 1, 0);
		drawSetup(c_white, 0.7);
		draw_rectangle(xx+32 - mw/2, yy-mh-mh/2-1, xx+32 + mw/2, yy-mh+mh/2-1, false);
		drawSetup(c_black);
		draw_text_transformed(xx+32, yy-mh, $"${players[i].money}", 1, 1, 0);
		draw_sprite_stretched(asset_get_index($"sPiece{players[i].piece}"), 0, xx, yy, 64, 64);
		if(!dice_rolling && dice1 != 0 && players[player_turn-1].id == players[i].id)
		{
			draw_sprite_stretched(sDice, dice1, xx + 32 - 32-4, yy + 80, 32, 32);
			draw_sprite_stretched(sDice, dice2, xx + 32 + 4, yy + 80, 32, 32);
		}
		xx += 80;
	}
	
	if(players[player_turn-1].id == my_player_id)
	{
		var mx = display_get_gui_width();
		var my = display_get_gui_height();
		drawSetup(c_white, 0.7);
		draw_rectangle(0, 0, mx, 64, false);
		//Display Action For Enter Key
		if(player_has_property)
		{
			drawSetup(c_white, 0.7);
			draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
			drawSetup(c_black, 0.7);
			draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
			draw_text(mx/2, 32, "Buy Property");
		}
		else
		{
			if(!dice_rolling && !player_turn_ready && spaces_left == 0)
			{
				drawSetup(c_white, 0.7);
				draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
				drawSetup(c_black, 0.7);
				draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
				draw_text(mx/2, 32, "Roll Dice");
			}
			else
			{
				if(player_turn_ready)
				{
					drawSetup(c_white, 0.7);
					draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, false);
					drawSetup(c_black, 0.7);
					draw_rectangle(mx/2 - 64, 16, mx/2 + 64, 48, true);
					draw_text(mx/2, 32, "End Turn");
				}
			}
		}
	}
}