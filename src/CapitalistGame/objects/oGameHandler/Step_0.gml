if(game_started)
{
	time_source_stop(ts_game_starting_counter);
}

#region Property Set Check
var property_sets = ds_map_create();
if(game_started)
{
	var brown_set = false;
	var light_blue_set = false;
	var pink_set = false;
	var orange_set = false;
	var red_set = false;
	var yellow_set = false;
	var green_set = false;
	var dark_blue_set = false;
	
	//PROPERTIES
	if(board[2].owner != undefined && board[2].owner == board[4].owner)
	{
		if(board[2].upgrade_state == 0) board[2].upgrade_state = 1;
		if(board[4].upgrade_state == 0) board[4].upgrade_state = 1;
		if(board[2].upgrade_state >= 1 && board[4].upgrade_state >= 1)
		{
			brown_set = true;
		}
	}

	if(board[7].owner != undefined && board[7].owner == board[9].owner && board[7].owner == board[10].owner)
	{
		if(board[7].upgrade_state == 0) board[7].upgrade_state = 1;
		if(board[9].upgrade_state == 0) board[9].upgrade_state = 1;
		if(board[10].upgrade_state == 0) board[10].upgrade_state = 1;
		if(board[7].upgrade_state >= 1 && board[9].upgrade_state >= 1 && board[10].upgrade_state >= 1)
		{
			light_blue_set = true;
		}
	}

	if(board[12].owner != undefined && board[12].owner == board[14].owner && board[12].owner == board[15].owner)
	{
		if(board[12].upgrade_state == 0) board[12].upgrade_state = 1;
		if(board[14].upgrade_state == 0) board[14].upgrade_state = 1;
		if(board[15].upgrade_state == 0) board[15].upgrade_state = 1;
		if(board[12].upgrade_state >= 1 && board[14].upgrade_state >= 1 && board[15].upgrade_state >= 1)
		{
			pink_set = true;
		}
	}

	if(board[17].owner != undefined && board[17].owner == board[19].owner && board[17].owner == board[20].owner)
	{
		if(board[17].upgrade_state == 0) board[17].upgrade_state = 1;
		if(board[19].upgrade_state == 0) board[19].upgrade_state = 1;
		if(board[20].upgrade_state == 0) board[20].upgrade_state = 1;
		if(board[17].upgrade_state >= 1 && board[19].upgrade_state >= 1 && board[20].upgrade_state >= 1)
		{
			orange_set = true;
		}
	}

	if(board[22].owner != undefined && board[22].owner == board[24].owner && board[22].owner == board[25].owner)
	{
		if(board[22].upgrade_state == 0) board[22].upgrade_state = 1;
		if(board[24].upgrade_state == 0) board[24].upgrade_state = 1;
		if(board[25].upgrade_state == 0) board[25].upgrade_state = 1;
		if(board[22].upgrade_state >= 1 && board[24].upgrade_state >= 1 && board[25].upgrade_state >= 1)
		{
			red_set = true;
		}
	}

	if(board[27].owner != undefined && board[27].owner == board[28].owner && board[27].owner == board[30].owner)
	{
		if(board[27].upgrade_state == 0) board[27].upgrade_state = 1;
		if(board[28].upgrade_state == 0) board[28].upgrade_state = 1;
		if(board[30].upgrade_state == 0) board[30].upgrade_state = 1;
		if(board[27].upgrade_state >= 1 && board[28].upgrade_state >= 1 && board[30].upgrade_state >= 1)
		{
			yellow_set = true;
		}
	}

	if(board[32].owner != undefined && board[32].owner == board[33].owner && board[32].owner == board[35].owner)
	{
		if(board[32].upgrade_state == 0) board[32].upgrade_state = 1;
		if(board[33].upgrade_state == 0) board[33].upgrade_state = 1;
		if(board[35].upgrade_state == 0) board[35].upgrade_state = 1;
		if(board[32].upgrade_state >= 1 && board[33].upgrade_state >= 1 && board[35].upgrade_state >= 1)
		{
			green_set = true;
		}
	}

	if(board[38].owner != undefined && board[38].owner == board[40].owner)
	{
		if(board[38].upgrade_state == 0) board[38].upgrade_state = 1;
		if(board[40].upgrade_state == 0) board[40].upgrade_state = 1;
		if(board[38].upgrade_state >= 1 && board[40].upgrade_state >= 1)
		{
			dark_blue_set = true;
		}
	}
	ds_map_add(property_sets, "brown", brown_set);
	ds_map_add(property_sets, "lightblue", light_blue_set);
	ds_map_add(property_sets, "pink", pink_set);
	ds_map_add(property_sets, "orange", orange_set);
	ds_map_add(property_sets, "red", red_set);
	ds_map_add(property_sets, "yellow", yellow_set);
	ds_map_add(property_sets, "green", green_set);
	ds_map_add(property_sets, "darkblue", dark_blue_set);
	
	//COMPANIES
	if(board[13].owner != undefined && board[13].owner == board[29].owner)
	{
		if(board[13].upgrade_state == 0) board[13].upgrade_state = 1;
		if(board[29].upgrade_state == 0) board[29].upgrade_state = 1;
	}
	//Rail Roads
	var rr_ownership = [];
	for(var i = 0; i < array_length(players); i++)
	{
		array_push(rr_ownership, []);
	}
	if(board[6].owner != undefined)
	{
		array_push(rr_ownership[getPlayerIndexFromID(board[6].owner.id)], 6);
	}
	if(board[16].owner != undefined)
	{
		array_push(rr_ownership[getPlayerIndexFromID(board[16].owner.id)], 16);
	}
	if(board[26].owner != undefined)
	{
		array_push(rr_ownership[getPlayerIndexFromID(board[26].owner.id)], 26);
	}
	if(board[36].owner != undefined)
	{
		array_push(rr_ownership[getPlayerIndexFromID(board[36].owner.id)], 36);
	}
	for(var i = 0; i < array_length(rr_ownership); i++)
	{
		for(var j = 0; j < array_length(rr_ownership[i]); j++)
		{
			board[rr_ownership[i][j]].upgrade_state = array_length(rr_ownership[i]) - 1;
		}
	}
}
#endregion

//Player Piece Movement on Board
if(spaces_left != 0 && !card_displayed)
{
	var current_space;
	if(vdice == 0)
	{
		current_space = players[player_turn-1].position + dice1 + dice2 - spaces_left;
	}
	else
	{
		current_space = players[player_turn-1].position + vdice - spaces_left;
	}
	var next_space = current_space + 1*sign(spaces_left);
	if(next_space > 40) next_space -= 40;
	if(next_space < 1) next_space += 40;
	if(current_space > 40) current_space -= 40;
	if(current_space < 1) current_space += 40;
	var new_pos = oCamera.get_player_xy_from_position(next_space, player_turn-1);
	new_pos.x += board[next_space].xx1;
	new_pos.y += board[next_space].yy1; 
	if(player_current_x != new_pos.x) player_current_x += sign(new_pos.x - player_current_x)*10;
	if(player_current_y != new_pos.y) player_current_y += sign(new_pos.y - player_current_y)*10;
	if(abs(player_current_x-new_pos.x) < 10) player_current_x = new_pos.x;
	if(abs(player_current_y-new_pos.y) < 10) player_current_y = new_pos.y;
	if(player_current_x == new_pos.x && player_current_y == new_pos.y) spaces_left -= sign(spaces_left);
	if(players[player_turn-1].position > 40) players[player_turn-1].position -= 40;
	if(current_space == 1 && !player_go_money_collected && players[player_turn-1].position != 1)
	{
		players[player_turn-1].money += 200;
		player_go_money_collected = true;
	}
	if(spaces_left == 0) 
	{
		vdice = 0;
		players[player_turn-1].position = next_space;
		player_turn_ready = true;
		if(players[player_turn-1].position == 1 && !player_go_money_collected)
		{
			players[player_turn-1].money += 200;
			player_go_money_collected = true;
		}
	}
}

//Board Space Actions
if(spaces_left == 0 && player_turn_ready && game_started && !players[player_turn-1].player_sold_property)
{
	var b_type = board[players[player_turn-1].position].type; 
	var b_owner = board[players[player_turn-1].position].owner; 
	var b_space = board[players[player_turn-1].position];
	if(b_type == "property" || b_type == "company" || b_type == "railroad")
	{
		if(b_owner == undefined)
		{
			player_has_property = true;
		}
		else
		{
			if(!player_payed_rent)
			{
				var ammount_due;
				if(b_type == "property")
				{
					ammount_due = b_space.rent[b_space.upgrade_state]
					player_payed_rent = true;
					players[player_turn-1].money -= ammount_due;
					b_space.owner.money += ammount_due;
				}
				else if(b_type == "company")
				{
					player_payed_rent = true;
					ammount_due = b_space.upgrade_state == 0 ? (dice1+dice2)*4 : (dice1+dice2)*10;
					players[player_turn-1].money -= ammount_due;
					b_space.owner.money += ammount_due;
				}
				else if(b_type == "railroad")
				{
					player_payed_rent = true;
					ammount_due = (b_space.upgrade_state+1)*50;
					players[player_turn-1].money -= ammount_due;
					b_space.owner.money += ammount_due;
				}
			}
		}
	}
	else if(b_type == "luxury_tax")
	{
		if(!player_payed_rent)
		{
			players[player_turn-1].money -= 75;
			player_payed_rent = true;
		}
	}
	else if(b_type == "income_tax")
	{
		if(!player_payed_rent)
		{
			players[player_turn-1].money -= 200 < players[player_turn-1].money ? 200 : floor(players[player_turn-1].money/10);
			player_payed_rent = true;
		}
	}
	else if(b_type == "chest")
	{
		if(!card_collected)
		{
			card_collected = true;
			card_displayed = true;
			var card = irandom(array_length(community_chest_cards)-1);
			//var card = 4;
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "game_event_display_card_chest", [INTEGER], [card]);
				}
			}
			card_index = 0;
		}
	}
	else if(b_type == "chance")
	{
		if(!card_collected)
		{
			card_collected = true;
			card_displayed = true;
			var card = irandom(array_length(chance_cards)-1);
			//card = 4; 
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "game_event_display_card_chance", [INTEGER], [card]);
				}
			}
			card_index = 0;
		}
	}
	else if(b_type == "to_jail")
	{
		if(!card_collected)
		{
			card_collected = true;
			var card = 4;
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "game_event_display_card_chance", [INTEGER], [card]);
				}
			}
		}
	}
}

#region Community Chest & Chance Actions
if(card_effect && !card_displayed)
{
	card_effect = false;
	var dist1, dist2, cost;
	if(card_type == "chest")
	{
		switch(community_chest_cards[card_index])
		{
			case "property_repairs" :
			cost = 0;
			for(var i = 1; i <= 40; i++)
			{
				if(board[i].owner != undefined)
				{
					if(board[i].owner == players[player_turn-1])
					{
						if(board[i].upgrade_state >= 2 && board[i].upgrade_state <= 5)
						{
							cost += 25 * (board[i].upgrade_state - 1);
						}
						else
						{
							if(board[i].upgrade_state == 6)
							{
								cost += 75;
							}
						}
					}
				}
			}
			players[player_turn-1].money -= cost;
			break;
			
			case "go_to_jail" :
			place_player_in_jail(players[player_turn-1].id);
			player_turn_ready = true;
			break;
			
			case "jail_card" :
			players[player_turn-1].jail_cards = clamp(players[player_turn-1].jail_cards+1, 0, 2);
			player_turn_ready = true;
			break;
			
			case "go_to_go" :
			player_turn_ready = false;
			dist1 = 1 - players[player_turn-1].position;
			dist2 = -1 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "collect_10" :
			players[player_turn-1].money += 10;
			player_turn_ready = true;
			break;
			
			case "collect_20" :
			players[player_turn-1].money += 200;
			player_turn_ready = true;
			break;
			
			case "collect_25" :
			players[player_turn-1].money += 25;
			player_turn_ready = true;
			break;
			
			case "collect_50" :
			players[player_turn-1].money += 50;
			player_turn_ready = true;
			break;
			
			case "collect_100" :
			players[player_turn-1].money += 100;
			player_turn_ready = true;
			break;
			
			case "pay_50" :
			players[player_turn-1].money -= 50;
			player_turn_ready = true;
			break;
			
			case "pay_100" :
			players[player_turn-1].money -= 100;
			player_turn_ready = true;
			break;
			
			case "pay_150" :
			players[player_turn-1].money -= 150;
			player_turn_ready = true;
			break;
			
			case "collect_50_from_players" :
			player_turn_ready = true;
			for(var i = 0; i < array_length(players); i++)
			{
				players[player_turn-1].money += 50;
				players[i].money -= 50;
			}
			break;
			
			default :
			break;
		}
	}
	else if(card_type == "chance")
	{
		switch(chance_cards[card_index])
		{
			case "property_repairs" :
			cost = 0;
			for(var i = 1; i <= 40; i++)
			{
				if(board[i].owner != undefined)
				{
					if(board[i].owner == players[player_turn-1])
					{
						if(board[i].upgrade_state >= 2 && board[i].upgrade_state <= 5)
						{
							cost += 25 * (board[i].upgrade_state - 1);
						}
						else
						{
							if(board[i].upgrade_state == 6)
							{
								cost += 75;
							}
						}
					}
				}
			}
			players[player_turn-1].money -= cost;
			break;
			
			case "go_to_jail":
			place_player_in_jail(players[player_turn-1].id);
			player_turn_ready = true;
			break;
			
			case "jail_card" :
			players[player_turn-1].jail_cards = clamp(players[player_turn-1].jail_cards+1, 0, 2);
			player_turn_ready = true;
			break;
			
			case "go_to_go" :
			player_turn_ready = false;
			dist1 = 1 - players[player_turn-1].position;
			dist2 = -1 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_railroad1" :
			player_turn_ready = false;
			dist1 = 6 - players[player_turn-1].position;
			dist2 = -6 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_red3" :
			player_turn_ready = false;
			dist1 = 25 - players[player_turn-1].position;
			dist2 = -25 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_darkblue2" :
			player_turn_ready = false;
			dist1 = 40 - players[player_turn-1].position;
			dist2 = -40 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_pink1" :
			player_turn_ready = false;
			dist1 = 12 - players[player_turn-1].position;
			dist2 = -12 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_nearest_company" :
			player_turn_ready = false;
			var company = min(abs(29 - players[player_turn-1].position), abs(13 - players[player_turn-1].position)) == abs(29 - players[player_turn-1].position) ? 29 : 13;
			dist1 = company - players[player_turn-1].position;
			dist2 = -company + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_nearest_railroad" :
			player_turn_ready = false;
			var railroad = min(abs(6 - players[player_turn-1].position), abs(16 - players[player_turn-1].position), abs(26 - players[player_turn-1].position), abs(36 - players[player_turn-1].position));
			if(railroad == abs(6 - players[player_turn-1].position)) railroad = 6;
			if(railroad == abs(16 - players[player_turn-1].position)) railroad = 16;
			if(railroad == abs(26 - players[player_turn-1].position)) railroad = 26;
			if(railroad == abs(36 - players[player_turn-1].position)) railroad = 36;
			dist1 = railroad - players[player_turn-1].position;
			dist2 = -railroad + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_back_3_spaces" :
			player_turn_ready = false;
			vdice = -3;
			spaces_left = vdice;
			break;
			
			case "collect_50" :
			players[player_turn-1].money += 50;
			player_turn_ready = true;
			break;
			
			case "collect_100" :
			players[player_turn-1].money += 100;
			player_turn_ready = true;
			break;
			
			case "pay_15" :
			players[player_turn-1].money -= 15;
			player_turn_ready = true;
			break;
			
			case "pay_50_to_players" :
			player_turn_ready = true;
			for(var i = 0; i < array_length(players); i++)
			{
				players[player_turn-1].money -= 50;
				players[i].money += 50;
			}
			break;
			
			default :
			break;
		}
	}
}
#endregion

#region Event Handling

if(array_length(events) > 0)
{
	#region Local Variables
	var index;
	var new_piece, new_color;
	#endregion
	switch(events[0].type)
	{
		#region Lobby Events
		case "player_ready" :
		index = getPlayerIndexFromID(events[0].id);
		updatePlayerReady(events[0].id, !players[index].ready);
		players_ready += power(-1, !players[index].ready);
		syncAllPlayers();
		break;
		
		case "player_request_new_piece" :
		index = getPlayerIndexFromID(events[0].id);
		new_piece = irandom(array_length(player_pieces)-1);
		array_push(player_pieces, players[index].piece);
		updatePlayerPiece(events[0].id, player_pieces[new_piece]);
		array_delete(player_pieces, new_piece, 1);
		syncAllPlayers();
		break;
		
		case "player_request_new_color" :
		index = getPlayerIndexFromID(events[0].id);
		new_color = irandom(array_length(player_colors)-1);
		array_push(player_colors, players[index].color);
		updatePlayerColor(events[0].id, oGameHandler.player_colors[new_color]);
		array_delete(player_colors, new_color, 1);
		syncAllPlayers();
		break;
		#endregion
		
		#region In-Game Client Events
		case "game_event_players_all_ready" :
		game_starting = true;
		time_source_start(ts_game_starting_counter);
		break;
		
		case "game_event_display_card_chest" : 
		card_displayed = true;
		card_effect = true;
		card_type = "chest";
		card_index = events[0].index;
		time_source_start(ts_card_display);
		break;
		
		case "game_event_display_card_chance" :
		card_displayed = true;
		player_turn_ready = false;
		card_effect = true;
		card_type = "chance";
		card_index = events[0].index;
		time_source_start(ts_card_display);
		break;
		
		case "player_event_trade_start" :
		trader1 = my_player_id;
		trader2 = events[0].other_player;
		trade_party1 = [];
		trade_party2 = [];
		trade_money1 = 0;
		trade_money2 = 0;
		break;
		
		case "player_event_dice_rolling" :
		dice1 = events[0].d1;
		dice2 = events[0].d2;
		dice_rolling = true;
		time_source_start(ts_dice_rolling);
		break;
		
		case "player_event_leave_jail" :
		players[player_turn-1].is_in_jail = false;
		players[player_turn-1].turns_in_jail = 0;
		if(events[0].leave == "jail_card")
		{
			players[player_turn-1].jail_cards--;
		}
		else
		{
			players[player_turn-1].money -= 50;
		}
		break;
		
		case "player_event_next_turn" :
		player_turn_ready = false;
		player_payed_rent = false;
		card_collected = false;
		dice1 = 0;
		player_go_money_collected = false;
		player_turn = events[0].next_turn;
		break;
		
		case "player_event_upgrade_start" :
		property_upgrade_active = true;
		property_upgrade_index = 1;
		while(board[property_upgrade_index].owner != players[player_turn-1])
		{
			property_upgrade_index++;
			if(property_upgrade_index > 40) property_upgrade_index = 1;
		}
		break;
		
		case "player_event_upgrade_end" :
		property_upgrade_active = false;
		break;
		
		case "player_event_upgrade" : 
		can_upgrade = true;
		players[player_turn-1].money -= board[property_upgrade_index].upgrade_cost;
		board[property_upgrade_index].upgrade_state++;
		break;
		
		case "player_event_downgrade" :
		can_upgrade = true;
		if(board[property_upgrade_index].type == "property")
		{ 
			var can_sell = true;
			for(var i = 1; i <= 40; i++)
			{
				if(i == property_upgrade_index) continue;
				if(board[i].owner == players[player_turn-1])
				{
					if(board[i].set == board[property_upgrade_index].set)
					{
						if(board[property_upgrade_index].type == "property")
						{
							if(board[i].upgrade_state >= 2)
							{
								can_sell = false;
								break;
							}
						}
					}
				}
			}
			if(board[property_upgrade_index].upgrade_state == 0 || board[property_upgrade_index].upgrade_state == 1)
			{
				if(can_sell)
				{
					players[player_turn-1].money += floor(board[property_upgrade_index].price/2);
					board[property_upgrade_index].owner = undefined;
					players[player_turn-1].player_sold_property = true;
				}
			}
			else
			{
				players[player_turn-1].money += floor(board[property_upgrade_index].upgrade_cost/2);
				board[property_upgrade_index].upgrade_state--;
			}
		}
		else
		{
			players[player_turn-1].money += floor(board[property_upgrade_index].price/2);
			board[property_upgrade_index].owner = undefined;
			players[player_turn-1].player_sold_property = true;
		}
		var still_has_properties = false;
		for(var i = 1; i <= 40; i++)
		{
			if(board[i].owner == players[player_turn-1])
			{
				still_has_properties = true;
				break;
			}
		}
		if(!still_has_properties) property_upgrade_active = false;
		break;
		
		case "player_event_next_property" :
		property_upgrade_index++;
		if(property_upgrade_index > 40) property_upgrade_index = 1;
		while(board[property_upgrade_index].owner != players[player_turn-1])
		{
			property_upgrade_index++;
			if(property_upgrade_index > 40) property_upgrade_index = 1;
		}
		break;
		
		case "player_event_previous_property" :
		property_upgrade_index--;
		if(property_upgrade_index < 1) property_upgrade_index = 40;
		while(board[property_upgrade_index].owner != players[player_turn-1])
		{
			property_upgrade_index--;
			if(property_upgrade_index < 1) property_upgrade_index = 40;
		}
		break;
		
		case "player_event_auction_start" :
		auction_active = true;
		auction_turn = player_turn;
		auction_value = floor(board[players[player_turn-1].position].price/2);
		last_bidder = "Capitalist Bank";
		last_bid = auction_value;
		for(var i = 0; i < array_length(players); i++)
		{
			auction_players[i] = i;
		}
		break;
		
		case "player_event_bid_100" :
		last_bidder = players[auction_players[auction_turn-1]].name;
		auction_turn++;
		if(auction_turn > array_length(auction_players))
		{
			auction_turn -= array_length(auction_players);
		}
		can_bid = true;
		last_bid = 100;
		auction_value += last_bid;
		break;
		
		case "player_event_bid_10" :
		last_bidder = players[auction_players[auction_turn-1]].name;
		auction_turn++;
		if(auction_turn > array_length(auction_players))
		{
			auction_turn -= array_length(auction_players);
		}
		can_bid = true;
		last_bid = 10;
		auction_value += last_bid;
		break;
		
		case "player_event_bid_withdraw" :
		array_delete(auction_players, auction_turn-1, 1);
		if(auction_turn == array_length(auction_players)+1)
		{
			auction_turn = 1;
		}
		can_bid = true;
		if(array_length(auction_players) == 1)
		{
			auction_active = false;
			last_bid = 0;
			players[auction_players[0]].money -= auction_value;
			auction_value = 0;
			board[players[player_turn-1].position].owner = players[auction_players[0]];
			player_payed_rent = true;
			player_has_property = false;
		}
		break;
		
		case "player_event_buy_property" :
		if(board[players[player_turn-1].position].owner == undefined)
		{
			board[players[player_turn-1].position].owner = players[player_turn-1];
		}
		player_has_property = false;
		break;
		#endregion
		
		#region Server Events
		case "player_key_press_enter" :
		if(!property_upgrade_active)
		{
			if(!auction_active)
			{
				if(!players[player_turn-1].is_in_jail || players[player_turn-1].turns_in_jail < 3)
				{
					if((!player_has_property || players[player_turn-1].player_sold_property))
					{
						if(!dice_rolling && !player_turn_ready)
						{
							dice1 = 1;
							dice2 = 0;
							//dice1 = irandom(5) + 1;
							//dice2 = irandom(5) + 1;
					
							with(oServerHandler)
							{
								for(var i = 0; i < array_length(clients); i++)
								{
									sendPacket(clients[i], "player_event_dice_rolling", [INTEGER, INTEGER], [other.dice1, other.dice2]);
								}
							}
							dice1 = 0;
						}
						else
						{
							if(player_turn_ready && !card_effect)
							{
								player_turn_ready = false;
								if(dice1 != dice2)
								{
									player_turn++;
									if(player_turn > array_length(players))
									{
										player_turn = 1;
									}
								}
								with(oServerHandler)
								{
									for(var i = 0; i < array_length(clients); i++)
									{
										sendPacket(clients[i], "player_event_next_turn", [INTEGER], [other.player_turn]);
									}
								}
							}
						}
					}
					else if(!players[player_turn-1].player_sold_property)
					{
						if(players[player_turn-1].money >= board[players[player_turn-1].position].price && board[players[player_turn-1].position].owner == undefined)
						{
							players[player_turn-1].money -= board[players[player_turn-1].position].price;
							board[players[player_turn-1].position].owner = players[player_turn-1];
							player_has_property = false;
							syncAllPlayers();
							with(oServerHandler)
							{
								for(var i = 0; i < array_length(clients); i++)
								{
									sendPacket(clients[i], "player_event_buy_property");
								}
							}
						}
					}
				}
				else
				{
					players[player_turn-1].is_in_jail = false;
					players[player_turn-1].turns_in_jail = 0;
					var leave_type;
					if(players[player_turn-1].jail_cards > 0)
					{
						leave_type = "jail_card";
					}
					else
					{
						leave_type = "money";	
					}
					with(oServerHandler)
					{
						for(var i = 0; i < array_length(clients); i++)
						{
							sendPacket(clients[i], "player_event_leave_jail", [STRING], [leave_type]);
						}
					}
				}
			}
			else
			{
				with(oServerHandler)
				{
					for(var i = 0; i < array_length(clients); i++)
					{
						sendPacket(clients[i], "player_event_bid_100");
					}
				}
			}
		}
		else
		{
			if(players[player_turn-1].money >= board[property_upgrade_index].upgrade_cost && can_upgrade)
			{
				if(property_sets[? board[property_upgrade_index].set] == true && board[property_upgrade_index].upgrade_state < 6)
				{
					can_upgrade = false;
					with(oServerHandler)
					{
						for(var i = 0; i < array_length(clients); i++)
						{
							sendPacket(clients[i], "player_event_upgrade");
						}
					}
				}
			}
		}
		break;
		
		case "player_key_press_space" :
		if(!auction_active)
		{
			if(player_has_property && !players[player_turn-1].player_sold_property)
			{
				auction_active = true;
				for(var i = 0; i < array_length(players); i++)
				{
					auction_players[i] = i;
				}
				auction_turn = player_turn;
				last_bidder = "Capitalist Bank"
				auction_value = floor(board[players[player_turn-1].position].price/2);
				last_bid = auction_value;
				with(oServerHandler)
				{
					for(var i = 0; i < array_length(clients); i++)
					{
						sendPacket(clients[i], "player_event_auction_start");
					}
				}
			}
			else
			{
				if(!property_upgrade_active)
				{
					if(player_turn_ready && !card_effect)
					{
						var player_owns_property = false;
						for(var i = 1; i <= 40; i++)
						{
							if(board[i].owner == players[player_turn-1])
							{
								player_owns_property = true;
								break;
							}
						}
						if(player_owns_property)
						{
							property_upgrade_active = true;
							with(oServerHandler)
							{
								for(var i = 0; i < array_length(clients); i++)
								{
									sendPacket(clients[i], "player_event_upgrade_start");
								}
							}
						}
					}
				}
				else
				{
					if(can_upgrade)
					{
						can_upgrade = false;
						with(oServerHandler)
						{
							for(var i = 0; i < array_length(clients); i++)
							{
								sendPacket(clients[i], "player_event_downgrade");
							}
						}
					}
				}
			}
		}
		else
		{
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "player_event_bid_10");
				}
			}
		}
		break;
		
		case "player_key_press_backspace" :
		if(!auction_active)
		{
			if(property_upgrade_active)
			{
				property_upgrade_active = false;
				with(oServerHandler)
				{
					for(var i = 0; i < array_length(clients); i++)
					{
						sendPacket(clients[i], "player_event_upgrade_end");
					}
				}
			}
		}
		else
		{
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "player_event_bid_withdraw");
				}
			}
		}
		break;
		
		case "player_key_press_a" :
		if(property_upgrade_active)
		{
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "player_event_next_property");
				}
			}
		}
		break;
		
		case "player_key_press_d" :
		if(property_upgrade_active)
		{
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "player_event_previous_property");
				}
			}
		}
		break;
		#endregion
		
		default :
		break;
	}
	array_shift(events);
}

#endregion



#region Lobby Actions
if(!game_started)
{
	if(keyboard_check_pressed(vk_space) && game_starting == false)
	{
		with(oClientHandler)
		{
			sendPacket(client, "player_ready");
		}
	}

	if(keyboard_check_pressed(ord("P")))
	{
		with(oClientHandler)
		{
			sendPacket(client, "player_request_new_piece");
		}
	}

	if(keyboard_check_pressed(ord("C")))
	{
		with(oClientHandler)
		{
			sendPacket(client, "player_request_new_color");
		}
	}
}
#endregion


#region Input

if(keyboard_check_pressed(ord("A")))
{
	key_press_a = true;
}

if(keyboard_check_pressed(ord("D")))
{
	key_press_d = true;
}

if(keyboard_check_pressed(vk_enter))
{
	key_press_enter = true;
}

if(keyboard_check_pressed(vk_space))
{
	key_press_space = true;
}

if(keyboard_check_pressed(vk_backspace))
{
	key_press_backspace = true;
}
#endregion




#region In-Game Actions
if(card_displayed == false)
{
	if(game_started && players[player_turn-1].id == my_player_id && !auction_active)
	{
		if(key_press_enter)
		{
			with(oClientHandler)
			{
				sendPacket(client, "player_key_press_enter");
			}
		}
		if(key_press_space)
		{
			with(oClientHandler)
			{
				sendPacket(client, "player_key_press_space");
			}
		}
		if(key_press_backspace)
		{
			with(oClientHandler)
			{
				sendPacket(client, "player_key_press_backspace");
			}
		}
		if(key_press_a)
		{
			with(oClientHandler)
			{
				sendPacket(client, "player_key_press_a");
			}
		}
		if(key_press_d)
		{
			with(oClientHandler)
			{
				sendPacket(client, "player_key_press_d");
			}
		}
	}
	else if(auction_active)
	{
		if(can_bid)
		{
			if(players[auction_players[auction_turn-1]].id == my_player_id)
			{
				if(players[auction_players[auction_turn-1]].money - auction_value - 100 >= 0)
				{
					if(key_press_enter)
					{
						with(oClientHandler)
						{
							sendPacket(client, "player_key_press_enter");
						}
						can_bid = false;
					}
				}
				if(players[auction_players[auction_turn-1]].money - auction_value - 10 >= 0)
				{
					if(key_press_space)
					{
						with(oClientHandler)
						{
							sendPacket(client, "player_key_press_space");
						}
						can_bid = false;
					}
				}
				if(key_press_backspace)
				{
					with(oClientHandler)
					{
						sendPacket(client, "player_key_press_backspace");
					}
					can_bid = false;
				}
			}
		}
	}
}
#endregion
key_press_space = false;
key_press_enter = false;
key_press_backspace = false;
key_press_a = false;
key_press_d = false;

if(players_ready == array_length(players) && players_ready != 0 && game_starting == false)
{
	game_starting = true;
	with(oServerHandler)
	{
		for(var i = 0; i < array_length(clients); i++)
		{
			sendPacket(clients[i], "game_event_players_all_ready");
		}
	}
}

ds_map_destroy(property_sets);
