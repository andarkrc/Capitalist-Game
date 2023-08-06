if(async_load[? "id"] == client)
{
	if(async_load[? "type"] == network_type_data)
	{
		var packet = async_load[? "buffer"];
		if(buffer_exists(packet))
		{
			buffer_seek(packet, buffer_seek_start, 0);
			var game_name = buffer_read(packet, STRING);
			var packet_type = buffer_read(packet, STRING);
			if(game_name == "Capitalist Game")
			{
				#region Local Variables
				var new_id, new_name, new_money, new_jail_cards, new_is_in_jail, new_turns_in_jail;
				var new_position, new_piece, new_ready, red, green, blue;
				var dice1, dice2, new_turn, card;
				var events = oGameHandler.events;
				#endregion
				
				switch(packet_type)
				{
					#region Player Sync
					case "player_sync_name" :
					new_id = buffer_read(packet, INTEGER);
					new_name = buffer_read(packet, STRING);
					updatePlayerName(new_id, new_name);
					break;
					
					case "player_sync_money" :
					new_id = buffer_read(packet, INTEGER);
					new_money = buffer_read(packet, INTEGER);
					updatePlayerMoney(new_id, new_money);
					break;
					
					case "player_sync_jail_cards" :
					new_id = buffer_read(packet, INTEGER);
					new_jail_cards = buffer_read(packet, INTEGER);
					updatePlayerJailCards(new_id, new_jail_cards);
					break;
					
					case "player_sync_is_in_jail" :
					new_id = buffer_read(packet, INTEGER);
					new_is_in_jail = buffer_read(packet, BOOL);
					updatePlayerIsInJail(new_id, new_is_in_jail);
					break;
					
					case "player_sync_turns_in_jail" :
					new_id = buffer_read(packet, INTEGER);
					new_turns_in_jail = buffer_read(packet, INTEGER);
					updatePlayerTurnsInJail(new_id, new_turns_in_jail);
					break;
					
					case "player_sync_position" :
					new_id = buffer_read(packet, INTEGER);
					new_position = buffer_read(packet, INTEGER);
					updatePlayerPosition(new_id, new_position);
					break;
					
					case "player_sync_piece" :
					new_id = buffer_read(packet, INTEGER);
					new_piece = buffer_read(packet, STRING);
					updatePlayerPiece(new_id, new_piece);
					break;
					
					case "player_sync_color" :
					new_id = buffer_read(packet, INTEGER);
					red = buffer_read(packet, INTEGER);
					green = buffer_read(packet, INTEGER);
					blue = buffer_read(packet, INTEGER);
					updatePlayerColor(new_id, make_color_rgb(red, green, blue));
					break;
					
					case "player_sync_ready" :
					new_id = buffer_read(packet, INTEGER);
					new_ready = buffer_read(packet, BOOL);
					updatePlayerReady(new_id, new_ready);
					break;
					#endregion
					
					#region In-Game Events
					case "game_event_players_all_ready" :
					array_push(events, {type : "game_event_players_all_ready"});
					break;
					
					case "game_event_display_card_chest" :
					card = buffer_read(packet, INTEGER);
					array_push(events, {type : "game_event_display_card_chest", index : card});
					break;
					
					case "game_event_display_card_chance" :
					card = buffer_read(packet, INTEGER);
					array_push(events, {type : "game_event_display_card_chance", index : card});
					break;
					
					case "player_event_dice_rolling" :
					dice1 = buffer_read(packet, INTEGER);
					dice2 = buffer_read(packet, INTEGER);
					array_push(events, {type : "player_event_dice_rolling", d1 : dice1, d2 : dice2});
					break;
					
					case "player_event_next_turn" :
					new_turn = buffer_read(packet, INTEGER);
					array_push(events, {type : "player_event_next_turn", next_turn : new_turn});
					break;
					
					case "player_event_buy_property" :
					array_push(events, {type : "player_event_buy_property"});
					break;
					#endregion
					
					case "client_id" :
					client_id = buffer_read(packet, INTEGER);
					oGameHandler.my_player_id = client_id;
					break;
					
					case "player_connected" :
					new_id = buffer_read(packet, INTEGER);
					initiatePlayer(new_id);
					if(new_id == client_id)
					{
						sendPacket(client, "player_info_request", [STRING], [global.player_name]);
					}
					break;
					
					default :
					break;
				}
			}
			buffer_seek(packet, buffer_seek_end, 0);
			buffer_delete(packet);
		}
	}
}