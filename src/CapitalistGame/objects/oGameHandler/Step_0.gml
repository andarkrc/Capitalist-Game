var dt = delta_time / 1000000;

#region Debug
/*
if (keyboard_check_pressed(vk_alt))
{
	for (var i = 0; i < array_length(players); i++)
	{
		players[i].is_in_jail = false;
	}
	packet_send(client.client, packet_create("hst_info_game_starting", [], [], 2));
}

if (keyboard_check_pressed(vk_left))
{
	for (var i = 0; i < array_length(players); i++)
	{
		players[i].position++;
		if (players[i].position > 40) players[i].position = 1;
	}
}

if (keyboard_check_pressed(vk_right))
{
	for (var i = 0; i < array_length(players); i++)
	{
		players[i].position--;
		if (players[i].position < 1) players[i].position = 40;
	}
}
*/

#endregion

#region Gameplay Buttons

if (game_state_is("game"))
{
	var midx = display_get_gui_width() / 2;
	var bottomy = display_get_gui_height();
	with (oButtonTextExtra)
	{
		instance_destroy();
	}
	switch(get_game_state())
	{
		case "game_waiting_to_roll":
		if (get_player_index_from_id(client.server_id) == player_turn)
		{
			create_roll_dice_button(midx - 64, bottomy - 224);
		}
		break;
		
		case "game_jail_waiting_to_roll":
		if (get_player_index_from_id(client.server_id) == player_turn)
		{
			create_roll_dice_button(midx - 224, bottomy - 224);
			create_pay_fee_secondary_button(midx - 64, bottomy - 224);
			create_use_card_extra_button(midx + 96, bottomy - 224);
		}
		break;
		
		case "game_jail_paying_fee":
		if (get_player_index_from_id(client.server_id) == player_turn)
		{
			create_pay_fee_primary_button(midx - 144, bottomy - 224);
			create_use_card_secondary_button(midx + 16, bottomy - 224);
		}
		break;
		
		case "game_purchasing_property":
		if (get_player_index_from_id(client.server_id) == player_turn)
		{
			create_purchase_property_button(midx - 144, bottomy - 224);
			create_auction_property_button(midx + 16, bottomy - 224);
		}
		break;
		
		case "game_turn_end":
		if (get_player_index_from_id(client.server_id) == player_turn)
		{
			create_end_turn_button(midx - 144, bottomy - 224);
			create_manage_properties_button(midx + 16, bottomy - 224);
		}
		break;
		
		case "game_upgrading_properties":
		if (get_player_index_from_id(client.server_id) == player_turn)
		{
			create_upgrade_property_button(midx - 304, bottomy - 224);
			create_downgrade_property_button(midx - 144, bottomy - 224);
			create_change_property_button(midx + 16, bottomy - 224);
			create_finish_managing_button(midx + 176, bottomy - 224);
		}
		break;
		
		case "game_auction":
		if (client.server_id == auction_members[auction_turn])
		{
			create_bet_100_button(midx - 224, bottomy - 224);
			create_bet_10_button(midx - 64, bottomy - 224);
			create_auction_withdraw_button(midx + 96, bottomy - 224);
		}
		break;
		
		default:
		break;
	}
}

#endregion

#region Input Detection
if (client.server_id >= 0)
{
	if (keyboard_check_pressed(ord("C")))
	{
		packet_send(client.client, packet_create("cl_info_key_press_change_color", [INT], [client.server_id]));
	}
	if (keyboard_check_pressed(vk_tab))
	{
		packet_send(client.client, packet_create("cl_info_key_press_change_piece", [INT], [client.server_id]));
	}
	if (keyboard_check_pressed(vk_space))
	{
		packet_send(client.client, packet_create("cl_info_key_press_primary", [INT], [client.server_id]));
	}
	if (keyboard_check_pressed(vk_enter))
	{
		packet_send(client.client, packet_create("cl_info_key_press_secondary", [INT], [client.server_id]));
	}
	if (keyboard_check_pressed(vk_control))
	{
		packet_send(client.client, packet_create("cl_info_key_press_extra", [INT], [client.server_id]));
	}
	if (keyboard_check_pressed(vk_left))
	{
		packet_send(client.client, packet_create("cl_info_key_press_next_property", [INT], [client.server_id]));
	}
	if (keyboard_check_pressed(vk_right))
	{
		packet_send(client.client, packet_create("cl_info_key_press_previous_property", [INT], [client.server_id]));
	}
}
#endregion

#region Misc Host Duties

if (ds_map_exists(client.listeners, "host"))
{
	if (get_game_state() == "lobby")
	{
		if (array_length(players) > 0 && array_length(players) == get_players_ready())
		{
			game_starting = true;
			packet_send(client.client, packet_create("hst_info_game_starting", [], [], 2));
		}
	}
}

#endregion

#region Piece Movement && Board Space Actions

if (positions_remaining != 0)
{
	players[player_turn].target = players[player_turn].position + sign(positions_remaining);
	if (players[player_turn].target > 40) players[player_turn].target = 1;
	if (players[player_turn].target < 1) players[player_turn].target = 40;
	var pos = get_player_position(player_turn, players[player_turn].target);
	var targetx = pos.x;
	var targety = pos.y;
	var xdir = sign(targetx - players[player_turn].x);
	var ydir = sign(targety - players[player_turn].y);
	if (point_distance(targetx, 0, players[player_turn].x, 0) > 8)
	{
		players[player_turn].x += player_move_speed * xdir * dt;
	}
	if (point_distance(targety, 0, players[player_turn].y, 0) > 8)
	{
		players[player_turn].y += player_move_speed * ydir * dt;
	}
	if (point_distance(targetx, targety, players[player_turn].x, players[player_turn].y) <= 16)
	{
		positions_remaining -= sign(positions_remaining);
		players[player_turn].position = players[player_turn].target;
		if (players[player_turn].position == 1)
		{
			players[player_turn].money += 200;
		}
	}
	if (positions_remaining == 0)
	{
		if (ds_map_exists(client.listeners, "host"))
		{
			var position = players[player_turn].position;
			switch (board[position].type)
			{
				case "chest":
				var idx = irandom_range(0, array_length(community_chest_cards) - 1);
				//idx = 4;
				packet_send(client.client, packet_create("hst_info_community_chest",
				[INT], [idx], 2));
				break;
				
				case "chance":
				var idx = irandom_range(0, array_length(chance_cards) - 1);
				//idx = 4;
				packet_send(client.client, packet_create("hst_info_chance",
				[INT], [idx], 2));
				break;
				
				default:
				break;
			}
		}
		switch(board[players[player_turn].position].type)
		{
			case "property":
			if (is_undefined(board[players[player_turn].position].owner))
			{
				property_purchased = false;
			}
			else if (!board[players[player_turn].position].mortgaged)
			{
				var pos = players[player_turn].position;
				players[player_turn].money -= board[pos].rent[board[pos].upgrade_state];
				var idx = get_player_index_from_id(board[pos].owner);
				players[idx].money += board[pos].rent[board[pos].upgrade_state];
			}
			break;
			
			case "railroad":
			if (is_undefined(board[players[player_turn].position].owner))
			{
				property_purchased = false;
			}
			if (!is_undefined(board[players[player_turn].position].owner))
			{
				var pos = players[player_turn].position;
				players[player_turn].money -= 50 * board[pos].upgrade_state;
				var idx = get_player_index_from_id(board[pos].owner);
				players[idx].money += 50 * board[pos].upgrade_state;
			}
			break;
			
			case "company":
			if (is_undefined(board[players[player_turn].position].owner))
			{
				property_purchased = false;
			}
			if (!is_undefined(board[players[player_turn].position].owner))
			{
				var pos = players[player_turn].position;
				players[player_turn].money -= (dice1_value + dice2_value) * board[pos].upgrade_state;
				var idx = get_player_index_from_id(board[pos].owner);
				players[idx].money += (dice1_value + dice2_value) * board[pos].upgrade_state;
			}
			break;
			
			case "income_tax":
			if (players[player_turn].money >= 200)
			{
				players[player_turn].money -= 200;
			}
			else
			{
				players[player_turn].money -= floor(0.1 * players[player_turn].money);
			}
			break;
			
			case "luxury_tax":
			players[player_turn].money -= 75;
			break;
			
			case "to_jail":
			jail_animation = true;
			time_source_start(ts_jail_animation);
			break;
			
			default:
			break;
		}
	}
}

#endregion

#region Community Chest & Chance Cards

if (get_game_state() == "game_card_in_action")
{
	if (card_type == "chest")
	{
		switch(community_chest_cards[active_card])
		{
			case "go_to_jail":
			jail_animation = true;
			time_source_start(ts_jail_animation);
			break;
			
			case "property_repairs":
			var cost = 0;
			for (var i = 1; i <= 40; i++)
			{
				if (board[i].owner == players[player_turn].id)
				{
					if (board[i].upgrade_state >= 2 && board[i].upgrade_state <= 5)
					{
						cost += 25 * (board[i].upgrade_state - 1);	
					}
					else if (board[i].upgrade_state == 6)
					{
						cost += 75;
					}
				}
			}
			players[player_turn].money -= cost;
			break;
			
			case "collect_50_from_players":
			players[player_turn].money += 50 * array_length(players);
			for (var i = 0; i < array_length(players); i++) 
			{
				players[i].money -= 50;
			}
			break;
			
			case "collect_200":
			players[player_turn].money += 200;
			break;
			
			case "collect_100":
			players[player_turn].money += 100;
			break;
			
			case "collect_50":
			players[player_turn].money += 50;
			break;
			
			case "collect_25":
			players[player_turn].money += 25;
			break;
			
			case "collect_20":
			players[player_turn].money += 20;
			break;
			
			case "collect_10":
			players[player_turn].money += 10;
			break;
			
			case "pay_150":
			players[player_turn].money -= 150;
			break;
			
			case "pay_100":
			players[player_turn].money -= 100;
			break;
			
			case "pay_50":
			players[player_turn].money -= 50;
			break;
			
			case "jail_card":
			players[player_turn].jail_cards = clamp(players[player_turn].jail_cards + 1, 0, 2);
			break;
			
			case "go_to_go":
			positions_remaining = 41 - players[player_turn].position;
			break;
			
			default:
			break;
		}
	}
	else if (card_type == "chance")
	{
		switch(chance_cards[active_card])
		{
			case "go_to_jail":
			jail_animation = true;
			time_source_start(ts_jail_animation);
			break;
			
			case "property_repairs":
			var cost = 0;
			for (var i = 1; i <= 40; i++)
			{
				if (board[i].owner == players[player_turn].id)
				{
					if (board[i].upgrade_state >= 2 && board[i].upgrade_state <= 5)
					{
						cost += 25 * (board[i].upgrade_state - 1);	
					}
					else if (board[i].upgrade_state == 6)
					{
						cost += 75;
					}
				}
			}
			players[player_turn].money -= cost;
			break;
			
			case "collect_100":
			players[player_turn].money += 100;
			break;
			
			case "collect_50":
			players[player_turn].money += 50;
			break;
			
			case "pay_50_to_players":
			players[player_turn].money -= 50 * array_length(players);
			for (var i = 0; i < array_length(players); i++) 
			{
				players[i].money += 50;
			}
			break;
			
			case "pay_15":
			players[player_turn].money -= 15;
			break;
			
			case "jail_card":
			players[player_turn].jail_cards = clamp(players[player_turn].jail_cards + 1, 0, 2);
			break;
			
			case "go_to_go":
			positions_remaining = 41 - players[player_turn].position;
			break;
			
			case "go_back_3_spaces":
			positions_remaining = -3;
			break;
			
			case "go_to_darkblue2":
			var dist1 = 40 - players[player_turn].position;
			var dist2 = -dist1;
			positions_remaining = (min(abs(dist1), abs(dist2)) == abs(dist1)) ? dist1 : dist2;
			break;
			
			case "go_to_railroad1":
			var dist1 = 6 - players[player_turn].position;
			var dist2 = -dist1;
			positions_remaining = (min(abs(dist1), abs(dist2)) == abs(dist1)) ? dist1 : dist2;
			break;
			
			case "go_to_red3":
			var dist1 = 25 - players[player_turn].position;
			var dist2 = -dist1;
			positions_remaining = (min(abs(dist1), abs(dist2)) == abs(dist1)) ? dist1 : dist2;
			break;
			
			case "go_to_pink1":
			var dist1 = 12 - players[player_turn].position;
			var dist2 = -dist1;
			positions_remaining = (min(abs(dist1), abs(dist2)) == abs(dist1)) ? dist1 : dist2;
			break;
			
			case "go_to_nearest_company":
			var company1_dist = abs(13 - players[player_turn].position);
			var company2_dist = abs(29 - players[player_turn].position);
			var company = 13;
			if (company2_dist < company1_dist) company = 29;
			var dist1 = company - players[player_turn].position;
			var dist2 = -dist1
			positions_remaining = (min(abs(dist1), abs(dist2)) == abs(dist1)) ? dist1 : dist2;
			break;
			
			case "go_to_nearest_railroad":
			var railroad1_dist = abs(6 - players[player_turn].position);
			var railroad2_dist = abs(16 - players[player_turn].position);
			var railroad3_dist = abs(26 - players[player_turn].position);
			var railroad4_dist = abs(36 - players[player_turn].position);
			var railroad = 6;
			if (railroad2_dist < railroad) railroad = 16;
			if (railroad3_dist < railroad) railroad = 26;
			if (railroad4_dist < railroad) railroad = 36;
			var dist1 = railroad - players[player_turn].position;
			var dist2 = -dist1
			positions_remaining = (min(abs(dist1), abs(dist2)) == abs(dist1)) ? dist1 : dist2;
			break;
			
			default:
			break;
		}
	}
	active_card = -1;
}

#endregion

#region Event Handling
if (array_length(events) > 0)
{
	
	var event = array_shift(events);
	
	buffer_seek(event, buffer_seek_start, 0);
	var trash = buffer_read(event, STRING);
	var event_type_ = buffer_read(event, STRING);
	switch(event_type_)
	{
		#region Host Duties
		
		case "sv_info_new_connection":
		var new_id = buffer_read(event, INT);
		packet_send(client.client, packet_create($"relay {new_id}",
		[STRING, INT], ["hst_req_info", client.server_id]));
		show_debug_message("[HOST] New connect. Requesting info.");
		break;
		
		case "cl_info_rsp_info":
		var new_id = buffer_read(event, INT);
		var new_name = buffer_read(event, STRING);
		array_push(players, new player(new_id, new_name));
		sync_players();
		show_debug_message($"[Host] Recieved info from {new_name}");
		break;
		
		case "cl_info_key_press_change_color":
		var new_id = buffer_read(event, INT);
		if (get_game_state() == "lobby" && !host_input_delay)
		{
			host_input_delay = true;
			packet_send(client.client, packet_create("hst_info_next_color", 
			[INT], [new_id], 2));
		}
		break;
		
		case "cl_info_key_press_change_piece":
		var new_id = buffer_read(event, INT);
		if (get_game_state() == "lobby" && !host_input_delay)
		{
			host_input_delay = true;
			packet_send(client.client, packet_create("hst_info_next_piece",
			[INT], [new_id], 2));
		}
		break;
		
		case "cl_info_key_press_primary":
		var new_id = buffer_read(event, INT);
		switch(get_game_state())
		{
			case "lobby":
			if (!host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_ready_change",
				[INT], [new_id], 2));
			}
			break;
			
			case "game_auction":
			if (new_id == auction_members[auction_turn] && !host_input_delay)
			{
				var pidx = get_player_index_from_id(new_id);
				if (players[pidx].money >= auction_value + 100)
				{
					host_input_delay = true;
					packet_send(client.client, packet_create("hst_info_new_bid",
					[INT], [100], 2));
				}
			}
			break;

			case "game_jail_paying_fee":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				rolling_dice = true;
				host_input_delay = true;
				dice1_value = irandom_range(1, 6);
				dice2_value = irandom_range(1, 6);
				packet_send(client.client, packet_create("hst_info_dice_rolling", 
				[INT, INT, STRING], [dice1_value, dice2_value, "money"], 2));
			}
			break;
			
			case "game_jail_waiting_to_roll":
			case "game_waiting_to_roll":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				rolling_dice = true;
				host_input_delay = true;
				dice1_value = irandom_range(1, 6);
				dice2_value = irandom_range(1, 6);
				//dice1_value = 0;
				//dice2_value = 1;
				packet_send(client.client, packet_create("hst_info_dice_rolling", 
				[INT, INT, STRING], [dice1_value, dice2_value, "none"], 2));
			}
			break;
			
			case "game_purchasing_property":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				if (is_undefined(board[players[player_turn].position].owner)
					&& players[player_turn].money >= board[players[player_turn].position].price)
				{
					host_input_delay = true;
					packet_send(client.client, packet_create("hst_info_property_purchased",
					[], [], 2));
				}
			}
			break;
			
			case "game_turn_end":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_turn_end",
				[], [], 2));
			}
			break;
			
			case "game_upgrading_properties":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				if (can_upgrade_property(selected_property) && players[player_turn].money >= board[selected_property].upgrade_cost)
				{
					host_input_delay = true;
					packet_send(client.client, packet_create("hst_info_property_upgraded",
					[], [], 2));
				}
			}
			break;
			
			default:
			break;
		}
		break;
		
		case "cl_info_key_press_secondary":
		var new_id = buffer_read(event, INT);
		switch(get_game_state())
		{
			case "game_auction":
			if (new_id == auction_members[auction_turn] && !host_input_delay)
			{
				var pidx = get_player_index_from_id(new_id);
				if (players[pidx].money >= auction_value + 10)
				{
					host_input_delay = true;
					packet_send(client.client, packet_create("hst_info_new_bid",
					[INT], [10], 2));
				}
			}
			break;
			
			case "game_jail_waiting_to_roll":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				rolling_dice = true;
				host_input_delay = true;
				dice1_value = irandom_range(1, 6);
				dice2_value = irandom_range(1, 6);
				packet_send(client.client, packet_create("hst_info_dice_rolling", 
				[INT, INT, STRING], [dice1_value, dice2_value, "money"], 2));
			}
			break;
			
			case "game_jail_paying_fee":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				if (players[player_turn].jail_cards > 0)
				{
					rolling_dice = true;
					host_input_delay = true;
					dice1_value = irandom_range(1, 6);
					dice2_value = irandom_range(1, 6);
					packet_send(client.client, packet_create("hst_info_dice_rolling", 
					[INT, INT, STRING], [dice1_value, dice2_value, "card"], 2));
				}
			}
			break;
			
			case "game_turn_end":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_upgrading_properties",
				[], [], 2));
			}
			break;
			
			case "game_upgrading_properties":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				if (can_downgrade_property(selected_property))
				{
					host_input_delay = true;
					packet_send(client.client, packet_create("hst_info_property_downgraded",
					[], [], 2));
				}
			}
			break;
			
			case "game_purchasing_property":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				if (is_undefined(board[players[player_turn].position].owner))
				{
					host_input_delay = true;
					packet_send(client.client, packet_create("hst_info_auction_start",
					[], [], 2));
				}
			}
			break;

			default:
			break;
		}
		break;
		
		case "cl_info_key_press_extra":
		var new_id = buffer_read(event, INT);
		switch(get_game_state())
		{
			case "game_auction":
			if (new_id == auction_members[auction_turn] && !host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_auction_withdraw",
				[], [], 2));
			}
			break;
			
			case "game_jail_waiting_to_roll":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				if (players[player_turn].jail_cards > 0)
				{
					rolling_dice = true;
					host_input_delay = true;
					dice1_value = irandom_range(1, 6);
					dice2_value = irandom_range(1, 6);
					packet_send(client.client, packet_create("hst_info_dice_rolling", 
					[INT, INT, STRING], [dice1_value, dice2_value, "card"], 2));
				}
			}
			break;
			
			case "game_upgrading_properties":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_finished_upgrading",
				[], [], 2));
			}
			break;
			
			default:
			break;
		}
		break;
		
		case "cl_info_key_press_next_property":
		var new_id = buffer_read(event, INT);
		switch(get_game_state())
		{
			case "game_upgrading_properties":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_next_property",
				[], [], 2));
			}
			break;
			
			default:
			break;
		}
		break;
		
		case "cl_info_key_press_previous_property":
		var new_id = buffer_read(event, INT);
		switch(get_game_state())
		{
			case "game_upgrading_properties":
			if (get_player_index_from_id(new_id) == player_turn && !host_input_delay)
			{
				host_input_delay = true;
				packet_send(client.client, packet_create("hst_info_previous_property",
				[], [], 2));
			}
			break;
			
			default:
			break;
		}
		break;
		
		#endregion
		
		#region Lobby
		
		case "hst_info_game_starting":
		game_starting = true;
		game_starting_counter = game_starting_time;
		time_source_start(ts_game_starting);
		break;
		
		case "hst_info_next_color":
		var p_id = buffer_read(event, INT);
		var p_idx = get_player_index_from_id(p_id);
		array_push(player_colors, players[p_idx].color);
		players[p_idx].color = array_shift(player_colors);
		host_input_delay = false;
		break;
		
		case "hst_info_next_piece":
		var p_id = buffer_read(event, INT);
		var p_idx = get_player_index_from_id(p_id);
		array_push(player_pieces, players[p_idx].piece);
		players[p_idx].piece = array_shift(player_pieces);
		host_input_delay = false;
		break;
		
		case "hst_info_ready_change":
		var p_id = buffer_read(event, INT);
		var p_idx = get_player_index_from_id(p_id);
		players[p_idx].ready = !players[p_idx].ready;
		host_input_delay = false;
		break;
		#endregion
		
		#region Game
		
		case "hst_info_auction_start":
		host_input_delay = false;
		auctioned_property = players[player_turn].position;
		for (var i = 0; i < array_length(players); i++)
		{
			auction_members[i] = players[i].id;
		}
		auction_value = floor(board[players[player_turn].position].price / 2);
		auction_turn = 0;
		break;
		
		case "hst_info_new_bid":
		host_input_delay = false;
		var bid_value = buffer_read(event, INT);
		auction_value += bid_value;
		auction_turn = (auction_turn + 1) % array_length(auction_members);
		break;
		
		case "hst_info_auction_withdraw":
		host_input_delay = false;
		array_delete(auction_members, auction_turn, 1);
		auction_turn = auction_turn % array_length(auction_members);
		if (array_length(auction_members) == 1)
		{
			var pidx = get_player_index_from_id(auction_members[0]);
			players[pidx].money -= auction_value;
			board[auctioned_property].owner = players[pidx].id;
			property_purchased = true;
			update_board_sets();
			auctioned_property = 0;
		}
		break;
		
		case "hst_info_turn_end":
		if (players[player_turn].is_in_jail || dice1_value != dice2_value)
		{
			consecutive_doubles = 0;
			player_turn = player_turn_next;
		}
			
		player_turn_next = (player_turn + 1) % array_length(players);
		dice1_value = 0;
		dice2_value = 0;
		game_waiting_to_roll = true;
		property_purchased = true;
		host_input_delay = false;
		break;
		
		case "hst_info_dice_rolling":
		dice1_value = buffer_read(event, INT);
		dice2_value = buffer_read(event, INT);
		var rolling_type = buffer_read(event, STRING);
		if (rolling_type == "money")
		{
			players[player_turn].money -= 50;
			players[player_turn].is_in_jail = false;
			players[player_turn].turns_in_jail = 0;
		} else if (rolling_type == "card")
		{
			players[player_turn].jail_cards--;
			players[player_turn].is_in_jail = false;
			players[player_turn].turns_in_jail = 0;
		}
		rolling_dice = true;
		host_input_delay = false;
		game_waiting_to_roll = false;
		time_source_start(ts_rolling_dice);
		break;
		
		case "hst_info_community_chest":
		active_card = buffer_read(event, INT);
		card_is_displayed = true;
		card_type = "chest";
		time_source_start(ts_card_display);
		break;
		
		case "hst_info_chance":
		active_card = buffer_read(event, INT);
		card_is_displayed = true;
		card_type = "chance";
		time_source_start(ts_card_display);
		break;
		
		case "hst_info_property_purchased":
		board[players[player_turn].position].owner = players[player_turn].id;
		players[player_turn].money -= board[players[player_turn].position].price;
		property_purchased = true;
		host_input_delay = false;
		update_board_sets();
		break;
		
		case "hst_info_upgrading_properties":
		selected_property = get_player_first_property(player_turn);
		host_input_delay = false;
		break;
		
		case "hst_info_finished_upgrading":
		selected_property = 0;
		host_input_delay = false;
		break;
		
		case "hst_info_next_property":
		for (var i = 1; i <= 41; i++)
		{
			selected_property++;
			if (selected_property > 40) selected_property = 1;
			if (board[selected_property].owner == players[player_turn].id)
			{
				break;
			}
		}
		host_input_delay = false;
		break;
		
		case "hst_info_previous_property":
		for (var i = 1; i <= 41; i++)
		{
			selected_property--;
			if (selected_property < 1) selected_property = 40;
			if (board[selected_property].owner == players[player_turn].id)
			{
				break;
			}
		}
		host_input_delay = false;
		break;
		
		case "hst_info_property_upgraded":
		host_input_delay = false;
		if (board[selected_property].mortgaged)
		{
			players[player_turn].money -= floor(board[selected_property].price / 2);
			board[selected_property].mortgaged = false;
		}
		else
		{
			players[player_turn].money -= board[selected_property].upgrade_cost;
			board[selected_property].upgrade_state++;
		}
		update_board_sets();
		break;
		
		case "hst_info_property_downgraded":
		host_input_delay = false;
		if (board[selected_property].upgradeable == false)
		{
			players[player_turn].money += floor(board[selected_property].price / 2);
			board[selected_property].mortgaged = true;
		}
		else if (board[selected_property].upgrade_state <= 1)
		{
			players[player_turn].money += floor(board[selected_property].price / 2);
			board[selected_property].mortgaged = true;
		}
		else
		{
			players[player_turn].money += board[selected_property].upgrade_cost;
			board[selected_property].upgrade_state--;
		}
		update_board_sets();
		break;
		
		#endregion
		
		#region Other
		case "hst_req_info":
		var hst_id = buffer_read(event, INT);
		packet_send(client.client, packet_create($"relay {hst_id}",
		[STRING, INT, STRING], ["cl_info_rsp_info", client.server_id, global.player_name]));
		show_debug_message("[CLIENT] Responded to host's info request");
		break;
		
		case "hst_info_player_sync":
		show_debug_message("[CLIENT] Syncing 1 player");
		var p_id = buffer_read(event, INT);
		var p_name = buffer_read(event, STRING);
		var p_idx = get_player_index_from_id(p_id);
		if (p_idx == -1)
		{
			p_idx = array_length(players);
			array_push(players, new player(p_id, p_name));
		}
		players[p_idx].money = buffer_read(event, INT);
		players[p_idx].jail_cards = buffer_read(event, INT);
		players[p_idx].is_in_jail = buffer_read(event, BOOL);
		players[p_idx].turns_in_jail = buffer_read(event, INT);
		players[p_idx].position = buffer_read(event, INT);
		players[p_idx].target = buffer_read(event, INT);
		players[p_idx].x = buffer_read(event, INT);
		players[p_idx].y = buffer_read(event, INT);
		players[p_idx].piece = buffer_read(event, STRING);
		var r = buffer_read(event, U8);
		var g = buffer_read(event, U8);
		var b = buffer_read(event, U8);
		players[p_idx].color = make_color_rgb(r, g, b);
		players[p_idx].ready = buffer_read(event, BOOL);
		
		var piece_idx = array_get_index(player_pieces, players[p_idx].piece);
		var color_idx = array_get_index(player_colors, players[p_idx].color);
		if (piece_idx != -1) array_delete(player_pieces, piece_idx, 1);
		if (color_idx != -1) array_delete(player_colors, color_idx, 1);
		break;
		#endregion
		
		default:
		break;
	}
	buffer_delete(event);
}


#endregion