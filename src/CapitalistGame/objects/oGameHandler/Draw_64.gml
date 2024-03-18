drawSetup(c_black, 1, fnMedium, fa_center, fa_middle);
draw_text_transformed(128, 64, $"Client: {global.player_name} {client.client_id}", 1, 1, 0);
switch(get_game_state())
{
	case "lobby_starting":
	{
		var midx = display_get_gui_width() / 2;
		drawSetup(c_red, 1, fnMedium, fa_center, fa_middle);
		draw_text(midx, 64, $"Game starting in {game_starting_counter}.{string_repeat(".", game_starting_counter)}");
	}
	case "lobby":
	{
		var midx = display_get_gui_width() / 2;
		var midy = display_get_gui_height() / 2;
		var slot_number = array_length(players);
		var slot_size = 128;
		var empty_space = 32;
		var lobby_size = slot_number * slot_size + (slot_number - 1) * empty_space;
		for (var i = 0; i < slot_number; i++)
		{
			var slot_x = midx - lobby_size / 2 + i * (slot_size + empty_space) + slot_size / 2;
			var slot_y = midy - slot_size;
			drawSetup(c_white, 0.8);
			drawSquare(slot_x, slot_y, slot_size);
			drawSetup(c_black, 1);
			drawSquare(slot_x, slot_y, slot_size, true);
			drawSetup(players[i].color, 1, fnMedium, fa_center, fa_bottom);
			draw_text(slot_x, slot_y - slot_size / 2, players[i].name);
			drawSetup(c_white);
			draw_sprite(asset_get_index($"sPiece{players[i].piece}"), 0, slot_x, slot_y);
			drawSetup(c_red);
			if(players[i].ready == true) drawSetup(c_green);
			draw_circle(slot_x + slot_size / 2, slot_y - slot_size / 2, 16, false);
		}
	}
	break;
	
	default: 
	break;
}