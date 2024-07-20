if (game_state_is("game"))
{
	draw_clear_alpha(c_white, 1);
	draw_surface(application_surface, 0, -192);
}

draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
draw_text_transformed(32, 32, $"Client: {global.player_name} {client.server_id}", 1, 1, 0);
draw_text_transformed(32, 64, $"Game State: {get_game_state()}", 1, 1, 0);
draw_text_transformed(32, 96, $"Pos remaining: {positions_remaining}", 1, 1, 0);
draw_text_transformed(32, 128, $"Selected: {selected_property}", 1, 1, 0);
switch(get_game_state())
{
	case "lobby_starting":
	{
		var midx = display_get_gui_width() / 2;
		draw_setup(c_red, 1, fnLeelawadee16, fa_center, fa_middle);
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
			draw_setup(c_white, 0.8);
			draw_square(slot_x, slot_y, slot_size);
			draw_setup(c_black, 1);
			draw_square(slot_x, slot_y, slot_size, true);
			draw_setup(players[i].color, 1, fnLeelawadee16, fa_center, fa_bottom);
			draw_text(slot_x, slot_y - slot_size / 2, players[i].name);
			draw_setup(c_white);
			draw_sprite(asset_get_index($"sPiece{players[i].piece}"), 0, slot_x, slot_y);
			draw_setup(c_red);
			if(players[i].ready == true) draw_setup(c_green);
			draw_circle(slot_x + slot_size / 2, slot_y - slot_size / 2, 16, false);
		}
	}
	break;
	
	case "game_display_card":
	var midx = display_get_gui_width() / 2;
	var midy = display_get_gui_height() / 2;
	if (card_type == "chance")
	{
		draw_sprite_ext(sChanceCards, active_card + 1, midx, midy, 3, 3, 0, c_white, 1);
	} else if (card_type == "chest")
	{
		draw_sprite_ext(sCommunityChestCards, active_card + 1, midx, midy, 3, 3, 0, c_white, 1);
	}
	break;
	
	default:
	break;
}

if (game_state_is("game_trade"))
{
	var midx = display_get_gui_width();
	var midy = display_get_gui_height();
	draw_setup(c_white, 0.8);
	draw_rectangle(midx / 8, midy / 8, 7 * midx / 8, 7 * midy / 8, false);
	draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
	draw_line_width(midx / 8, midy / 2, 7 * midx / 8 - 1, midy / 2, 2);
	draw_rectangle(midx / 8, midy / 8, 7 * midx / 8, 7 * midy / 8, true);
	
	draw_text(midx / 8 + 32, midy / 2 - 48, $"Money: {trade_given_money},");
	draw_text(midx / 8 + 64 + string_width($"Money: {trade_given_money},"), midy / 2 - 48, $"Jail Cards: {trade_given_cards}");

	draw_text(midx / 8 + 32, 7 * midy / 8 - 48, $"Money: {trade_recieved_money},");
	draw_text(midx / 8 + 64 + string_width($"Money: {trade_recieved_money},"), 7 * midy / 8 - 48, $"Jail Cards: {trade_recieved_cards}");

	if (get_player_index_from_id(client.server_id) == player_turn)
	{
		draw_sprite_ext(sTradeArrow, 0, 7 * midx / 8 - 80, midy / 2 - 80, 1, 1, 0, c_red, 1);
		
		draw_sprite_ext(sTradeArrow, 0, 7 * midx / 8 - 16, 7 * midy / 8 - 80, -1, 1, 0, c_green, 1);
	}
	else if (get_player_index_from_id(client.server_id) == trade_target)
	{
		draw_sprite_ext(sTradeArrow, 0, 7 * midx / 8 - 16, midy / 2 - 80, -1, 1, 0, c_green, 1);
		
		draw_sprite_ext(sTradeArrow, 0, 7 * midx / 8 - 80, 7 * midy / 8 - 80, 1, 1, 0, c_red, 1);
	}
	else
	{
		draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
		draw_text(midx / 8 + 16, midy / 8 + 24, $"{players[player_turn].name} gives:");
		draw_text(midx / 8 + 16, midy / 2 + 24, $"{players[player_turn].name} recieves:");
	}
}

if (get_game_state() == "game_auction")
{
	var midx = display_get_gui_width();
	var midy = display_get_gui_height();
	var pos = players[player_turn].position;
	draw_setup(c_white, 0.8);
	draw_rectangle(midx / 4, midy / 4, 3 * midx / 4, 3 * midy / 4, false);
	draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
	draw_rectangle(midx / 4, midy / 4, 3 * midx / 4, 3 * midy / 4, true);
	draw_text(midx / 4  + 32, midy / 4 + 32, $"Property name: {board[pos].name}");
	draw_text(midx / 4  + 32, midy / 4 + 64, $"Auction value: {auction_value}");
	draw_text(midx / 4  + 32, midy / 4 + 96, "Auction participants:");
	for (var i = 0; i < array_length(auction_members); i++)
	{
		var pidx = get_player_index_from_id(auction_members[i]);
		draw_setup(players[pidx].color, 1, fnLeelawadee16, fa_left, fa_middle);
		draw_text(midx / 4 + 32, midy / 4 + 128 + i * 32, players[pidx].name);
	}
}

if (game_state_is("game"))
{
	var midx = display_get_gui_width() / 2;
	var midy = display_get_gui_height() / 2;
	var slot_number = array_length(players);
	var slot_size = 64;
	var empty_space = 64;
	var lobby_size = slot_number * slot_size + (slot_number - 1) * empty_space;
	for (var i = 0; i < slot_number; i++)
	{
		var slot_x = midx - lobby_size / 2 + i * (slot_size + empty_space) + slot_size / 2;
		var slot_y = 2 * midy - 48;
		draw_setup(c_white, 0.8);
		draw_square(slot_x, slot_y, slot_size);
		draw_setup(c_black, 1);
		draw_square(slot_x, slot_y, slot_size, true);
		draw_setup(c_white);
		draw_sprite_stretched(asset_get_index($"sPiece{players[i].piece}"), 0, slot_x - slot_size / 2, slot_y - slot_size / 2, slot_size, slot_size);
		draw_setup(players[i].color, 1, fnLeelawadee16, fa_center, fa_bottom);
		draw_text(slot_x, slot_y - 8 * slot_size / 11, players[i].name);
		draw_setup(c_black, 1, fnLeelawadee16, fa_center, fa_bottom);
		draw_text(slot_x, slot_y - 5 * slot_size / 11, $"{players[i].money}$");
		draw_sprite_ext(sJailCard, players[i].jail_cards, slot_x - 28, slot_y - 96, 0.7, 0.7, 0, c_white, 1);
		
		if (player_turn == i && dice1_value != 0 && get_game_state() != "game_rolling_dice")
		{
			draw_sprite_stretched(asset_get_index($"sDice{consecutive_doubles}"), dice1_value, slot_x - 0.5 * slot_size, slot_y - 1.8 * slot_size, 0.4 * slot_size, 0.4 * slot_size);
			draw_sprite_stretched(asset_get_index($"sDice{consecutive_doubles}"), dice2_value, slot_x + 0.1 * slot_size, slot_y - 1.8 * slot_size, 0.4 * slot_size, 0.4 * slot_size);
		}
	}
}