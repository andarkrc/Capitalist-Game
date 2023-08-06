if(game_started)
{
	time_source_stop(ts_game_starting_counter);
}

#region Property Set Check
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

if(spaces_left == 0 && player_turn_ready && game_started)
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
			var card = irandom(array_length(community_chest_cards)-1);
			//var card = 5;
			with(oServerHandler)
			{
				for(var i = 0; i < array_length(clients); i++)
				{
					sendPacket(clients[i], "game_event_display_card_chest", [INTEGER], [card]);
				}
			}
		}
	}
	else if(b_type == "chance")
	{
		if(!card_collected)
		{
			card_collected = true;
			var card = irandom(array_length(chance_cards)-1);
			card = array_length(chance_cards)-1; 
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

#region Community Chest Actions
if(card_effect && !card_displayed)
{
	card_effect = false;
	if(card_type == "chest")
	{
		switch(community_chest_cards[card_index])
		{
			case "property_repairs" :
			break;
			
			case "go_to_jail" :
			break;
			
			case "jail_card" :
			players[player_turn-1].jail_cards = clamp(players[player_turn-1].jail_cards+1, 0, 2);
			break;
			
			case "go_to_go" :
			player_turn_ready = false;
			var dist1 = 1 - players[player_turn-1].position;
			var dist2 = -1 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "collect_10" :
			players[player_turn-1].money += 10;
			break;
			
			case "collect_20" :
			players[player_turn-1].money += 200;
			break;
			
			case "collect_25" :
			players[player_turn-1].money += 25;
			break;
			
			case "collect_50" :
			players[player_turn-1].money += 50;
			break;
			
			case "collect_100" :
			players[player_turn-1].money += 100;
			break;
			
			case "pay_50" :
			players[player_turn-1].money -= 50;
			break;
			
			case "pay_100" :
			players[player_turn-1].money -= 100;
			break;
			
			case "pay_150" :
			players[player_turn-1].money -= 150;
			break;
			
			case "collect_50_from_players" :
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
			break;
			
			case "go_to_jail":
			break;
			
			case "jail_card" :
			players[player_turn-1].jail_cards = clamp(players[player_turn-1].jail_cards+1, 0, 2);
			break;
			
			case "go_to_go" :
			player_turn_ready = false;
			var dist1 = 1 - players[player_turn-1].position;
			var dist2 = -1 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_railroad1" :
			player_turn_ready = false;
			var dist1 = 6 - players[player_turn-1].position;
			var dist2 = -6 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_red3" :
			player_turn_ready = false;
			var dist1 = 25 - players[player_turn-1].position;
			var dist2 = -25 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_darkblue2" :
			player_turn_ready = false;
			var dist1 = 40 - players[player_turn-1].position;
			var dist2 = -40 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_pink1" :
			player_turn_ready = false;
			var dist1 = 12 - players[player_turn-1].position;
			var dist2 = -12 + players[player_turn-1].position;
			vdice = min(abs(dist1), abs(dist2)) == abs(dist1) ? dist1 : dist2;
			spaces_left = vdice;
			break;
			
			case "go_to_nearest_company" :
			player_turn_ready = false;
			var company = min(abs(29 - players[player_turn-1].position), abs(13 - players[player_turn-1].position)) == abs(29 - players[player_turn-1].position) ? 29 : 13;
			var dist1 = company - players[player_turn-1].position;
			var dist2 = -company + players[player_turn-1].position;
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
			var dist1 = railroad - players[player_turn-1].position;
			var dist2 = -railroad + players[player_turn-1].position;
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
			break;
			
			case "collect_100" :
			players[player_turn-1].money += 100;
			break;
			
			case "pay_15" :
			players[player_turn-1].money -= 15;
			break;
			
			case "pay_50_to_players" :
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
		card_effect = true;
		card_type = "chance";
		card_index = events[0].index;
		time_source_start(ts_card_display);
		break;
		
		case "player_event_dice_rolling" :
		dice1 = events[0].d1;
		dice2 = events[0].d2;
		dice_rolling = true;
		time_source_start(ts_dice_rolling);
		break;
		
		case "player_event_next_turn" :
		player_turn_ready = false;
		player_payed_rent = false;
		card_collected = false;
		dice1 = 0;
		player_go_money_collected = false;
		player_turn = events[0].next_turn;
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
		if(!player_has_property)
		{
			if(!dice_rolling && !player_turn_ready)
			{
				//dice1 = irandom(5) + 1;
				//dice2 = irandom(5) + 1;
				dice1 = 0;
				dice2 = 7;
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
		else
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

#region In-Game Actions
if(game_started && players[player_turn-1].id == my_player_id)
{
	if(keyboard_check_pressed(vk_enter))
	{
		with(oClientHandler)
		{
			sendPacket(client, "player_key_press_enter");
		}
	}
}
#endregion

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
