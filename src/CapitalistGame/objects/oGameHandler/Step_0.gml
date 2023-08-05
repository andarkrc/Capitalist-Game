if(game_started)
{
	time_source_stop(ts_game_starting_counter);
}

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
				player_payed_rent = true;
				players[player_turn-1].money -= b_space.rent[b_space.upgrade_state];
				b_space.owner.money += b_space.rent[b_space.upgrade_state];
			}
		}
	}
	
}

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
		
		case "player_event_dice_rolling" :
		dice1 = events[0].d1;
		dice2 = events[0].d2;
		dice_rolling = true;
		time_source_start(ts_dice_rolling);
		break;
		
		case "player_event_next_turn" :
		player_turn_ready = false;
		player_payed_rent = false;
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
				dice2 = 3;
				with(oServerHandler)
				{
					for(var i = 0; i < array_length(clients); i++)
					{
						sendPacket(clients[i], "player_event_dice_rolling", [INTEGER, INTEGER], [other.dice1, other.dice2]);
					}
				}
			}
			else
			{
				if(player_turn_ready)
				{
					player_turn_ready = false;
					player_turn++;
					if(player_turn > array_length(players))
					{
						player_turn = 1;
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
