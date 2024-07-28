if (game_state_is("game") && !(get_game_state() == "game_ended"))
{
	draw_clear_alpha(c_white, 1);
	draw_setup(c_white);
	draw_surface(application_surface, 0, -224);
	draw_setup(c_black);
	draw_line_width(0, display_get_gui_height() - 224, display_get_gui_width(), display_get_gui_height() - 224, 2);
}

if (get_game_state() == "game_ended")
{
	draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
	draw_text(64, 64, "Winners are:");
	for (var i = 0; i < array_length(game_end_list); i++)
	{
		draw_setup(game_end_list[i].color, 1, fnLeelawadee16, fa_left, fa_middle);
		draw_text(64, 96 + 32 * i, game_end_list[i].name);
	}
	draw_setup(c_black, 1, fnLeelawadee16, fa_right, fa_middle);
	draw_text(display_get_gui_width() / 2, 64, $"Returning to lobby in {game_returning_to_lobby_counter}");
}

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
	var topleftx = 135;
	var toplefty = 90;
	var width = 810;
	var height = 540;
	var midx = display_get_gui_width();
	var midy = display_get_gui_height();
	draw_setup(c_white, 0.8);
	draw_rectangle(topleftx, toplefty, topleftx + width, toplefty + height, false);
	draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
	draw_line_width(topleftx, toplefty + height / 2, topleftx + width - 1, toplefty + height / 2, 2);
	draw_rectangle(topleftx, toplefty, topleftx + width, toplefty + height, true);
	
	draw_text(topleftx + 32, toplefty + height / 2 - 48, $"Money: {trade_given_money},");
	draw_text(topleftx + 64 + string_width($"Money: {trade_given_money},"), toplefty + height / 2 - 48, $"Jail Cards: {trade_given_cards}");

	draw_text(topleftx + 32, toplefty + height - 48, $"Money: {trade_recieved_money},");
	draw_text(topleftx + 64 + string_width($"Money: {trade_recieved_money},"), toplefty + height - 48, $"Jail Cards: {trade_recieved_cards}");

	if (get_player_index_from_id(client.server_id) == player_turn)
	{
		draw_sprite_ext(sTradeArrow, 0, topleftx + width - 80, toplefty + height / 2 - 80, 1, 1, 0, c_red, 1);
		
		draw_sprite_ext(sTradeArrow, 0, topleftx + width - 16, toplefty + height - 80, -1, 1, 0, c_green, 1);
	}
	else if (get_player_index_from_id(client.server_id) == trade_target)
	{
		draw_sprite_ext(sTradeArrow, 0, topleftx + width - 16, toplefty + height / 2 - 80, -1, 1, 0, c_green, 1);
		
		draw_sprite_ext(sTradeArrow, 0, topleftx + width - 80, toplefty + height - 80, 1, 1, 0, c_red, 1);
	}
	else
	{
		draw_setup(c_black, 1, fnLeelawadee16, fa_left, fa_middle);
		draw_text(topleftx + 16, toplefty + 24, $"{players[player_turn].name} gives:");
		draw_text(topleftx + 16, toplefty + height / 2 + 24, $"{players[player_turn].name} recieves:");
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

if (game_state_is("game") && !(get_game_state() == "game_ended"))
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