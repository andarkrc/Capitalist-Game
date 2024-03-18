var game_state = get_game_state();
#region Input Handling
var input = "";
if (keyboard_check_pressed(vk_enter))
{
	input = "input_primary";
}
if (keyboard_check_pressed(vk_space))
{
	input = "input_secondary";
}
if (keyboard_check_pressed(vk_escape))
{
	input = "input_exit";
}
if (keyboard_check_pressed(vk_lshift))
{
	input = "input_left_scroll";
}
if (keyboard_check_pressed(vk_rshift))
{
	input = "input_right_scroll";
}
if (keyboard_check_pressed(vk_control))
{
	input = "input_extra";
}
sendPacket(client.client, input, [INTEGER], [client.client_id]);
#endregion
#region Game Starting
if (game_state == "lobby")
{
	if (get_players_ready() == array_length(players) && array_length(players) >= 1)
	{
		game_starting = true;
		with (server)
		{
			sendPacketAll(clients, "game_starting");
		}
	}
}
#endregion


#region Event Handling
if (array_length(events) != 0)
{
	var event = array_shift(events);
	game_state = get_game_state();
	switch(event.type)
	{
		#region Player Handling
		case "init_player":
		{
			var player_exists = false;
			for (var i = 0; i < array_length(players); i++)
			{
					if (players[i].id == event.id)
					{
						player_exists = true;
						break;
					}
			}
			if (player_exists) break;
			var new_player = new player(event.id, 1500, event.name, event.piece, event.color);
			array_push(players, new_player);
		}
		break;
		
		case "player_disconnect" :
		{
			if (game_state == "lobby")
			{
				var index = getPlayerIndexFromID(event.id);
				array_delete(players, index, 1);
			}
		}
		break;
		
		case "player_sync" :
		{
			var index = getPlayerIndexFromID(event.id);
			if (index == -1) break;
			players[index].name = event.name;
			players[index].money = event.money;
			players[index].jail_cards = event.jail_cards;
			players[index].is_in_jail = event.is_in_jail;
			players[index].turns_in_jail = event.turns_in_jail;
			players[index].position = event.position;
			players[index].piece = event.piece;
			players[index].color = event.color;
			players[index].ready = event.ready;
		}
		break;
		#endregion
		
		case "game_starting":
		{
			game_starting = true;
			game_starting_counter = game_starting_time;
			time_source_start(game_starting_ts);
		}
		break;
		
		#region Actual Gameplay
		case "input_primary" : 
		{
			if (game_state == "lobby")
			{
				var index = getPlayerIndexFromID(event.id);
				players[index].ready = !players[index].ready;
			}
		}
		break;
		
		case "input_secondary" :
		{
			if (game_state == "lobby")
			{
				if (event.id == client.client_id)
				{
					sendPacket(client.client, "player_piece_request", [INTEGER], [client.client_id]);
				}
			}
		}
		break;
		
		case "input_extra" :
		{
			if (game_state == "lobby")
			{
				if (event.id == client.client_id)
				{
					sendPacket(client.client, "player_color_request", [INTEGER], [client.client_id]);
				}
			}
		}
		#endregion
		
		default:
		break;
	}
}
#endregion

