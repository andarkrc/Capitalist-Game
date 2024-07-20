randomize();
server = undefined;
client = undefined;

game_started = false;
game_starting = false;
game_starting_time = 1;
game_ended = false;
game_ending = false;
game_ending_time = 2;
game_returning_to_lobby_counter = 5;
game_returning_to_lobby_time = 5;
game_end_list = [];
game_starting_counter = 0;
players_ready = 0;
player_turn = 0;
player_turn_next = 1;
player_move_speed = 300; // Pixels / Seconds

game_waiting_to_roll = true;
consecutive_doubles = 0;
rolling_dice = false;
rolling_dice_time = 1;
dice1_value = 0;
dice2_value = 0;
positions_remaining = 0;

card_is_displayed = false;
card_display_time = 3;
community_chest_cards = ["collect_100", "pay_50", "collect_25", "property_repairs", "go_to_jail", "go_to_go", "collect_200", "pay_150", "collect_50", "collect_10", "pay_100", "jail_card", "collect_20", "collect_50_from_players"];
chance_cards = ["go_to_go", "pay_15", "go_to_railroad1", "collect_50", "go_to_jail", "pay_50_to_players", "go_to_red3", "go_to_nearest_company", "go_to_nearest_railroad", "jail_card", "go_back_3_spaces", "property_repairs", "collect_100", "go_to_darkblue2", "go_to_pink1"];
card_type = "";
active_card = -1;

jail_animation = false;
jail_animation_time = 2;

property_purchased = true;

selected_property = 0;

auction_members = [];
auction_turn = 0;
auctioned_property = 0;
auction_value = 0;

trade_target = -1;
trade_sent = false;
trade_given_money = 0;
trade_recieved_money = 0;
trade_given_properties = [];
trade_recieved_properties = [];
trade_given_cards = 0;
trade_recieved_cards = 0;

host_input_delay = false;


dice_rotation = 
{
	x : 0,
	y : 0,
	z : 0
};


if (global.connection_type == "server")
{
	server = instance_create_layer(0, 0, "Handlers", oServerHandler);
}
client = instance_create_layer(0, 0, "Handlers", oClientHandler);
ds_map_add(client.listeners, "game", id);


events = [];

player_colors = [c_blue, c_green, c_red, c_purple, c_aqua, c_yellow, c_orange, c_lime, c_fuchsia, c_teal];
player_pieces = ["Bike", "Cat", "Dog", "Duck", "Potato", "Rat"];

#region Time Sources
var fn = function()
{
	if (game_returning_to_lobby_counter > 0)
	{
		game_returning_to_lobby_counter--;
	}
	if (game_returning_to_lobby_counter == 0)
	{
		game_ended = false;
		game_started = false;
		for (var i = 0 ; i < array_length(game_end_list); i++)
		{
			array_push(players, game_end_list[i]);
			players[i].ready = false;
		}
		game_end_list = [];
	}
}
ts_return_to_lobby = time_source_create(time_source_game, 1, time_source_units_seconds, fn, [], game_returning_to_lobby_time);

var fn = function()
{
	array_insert(game_end_list, 0, players[0]);
	array_delete(players, 0, 1);
	with(oCamera)
	{
		instance_destroy();
	}
	game_ending = false;
	game_ended = true;
	game_returning_to_lobby_counter = game_returning_to_lobby_time;
	time_source_start(ts_return_to_lobby);
}
ts_game_ending = time_source_create(time_source_game, game_ending_time, time_source_units_seconds, fn);

var fn = function()
{
	if (game_starting_counter > 0) 
	{
		game_starting_counter--;
	}
	if (game_starting_counter == 0)
	{
		game_starting = false;
		game_started = true;
		game_ended = false;
		game_ending = false;
		player_turn = 0;
		player_turn_next = 1;
		game_waiting_to_roll = true;
		consecutive_doubles = 0;
		rolling_dice = false;
		property_purchased = true;
		positions_remaining = 0;
		game_end_list = [];
		instance_create_layer(0, 0, "Instances", oCamera);
	}
}
ts_game_starting = time_source_create(time_source_game, 1, time_source_units_seconds, fn, [], game_starting_time);

var fn = function()
{
	jail_animation = false;
	put_player_in_jail();
}
ts_jail_animation = time_source_create(time_source_game, jail_animation_time, time_source_units_seconds, fn);

var fn = function()
{
	if (dice1_value == dice2_value)
	{
		consecutive_doubles++;
	}
	if (consecutive_doubles == 3)
	{
		jail_animation = true;
		rolling_dice = false;
		time_source_start(ts_jail_animation);
		return;
	}
	if (!players[player_turn].is_in_jail)
	{
		rolling_dice = false;
		positions_remaining = dice1_value + dice2_value;
	}
	else if (dice1_value == dice2_value)
	{
		rolling_dice = false;
		positions_remaining = dice1_value + dice2_value;
		players[player_turn].is_in_jail = false;
		players[player_turn].turns_in_jail = 0;
	}
	else
	{
		players[player_turn].turns_in_jail++;
		rolling_dice = false;
	}
}
ts_rolling_dice = time_source_create(time_source_game, rolling_dice_time, time_source_units_seconds, fn);

var fn = function()
{
	card_is_displayed = false;
}
ts_card_display = time_source_create(time_source_game, card_display_time, time_source_units_seconds, fn);

#endregion

///@function get_game_state
get_game_state = function()
{
	if (game_starting == true) return "lobby_starting";
	if (game_started == false) return "lobby";
	if (game_ending == true) return "game_ending";
	if (game_ended == true) return "game_ended";
	if (jail_animation == true) return "game_jail_animation";
	if (trade_target > 0)
	{
		if (!trade_sent)
		{
			return "game_trade";
		}
		else
		{
			return "game_trade_sent";
		}
	}
	if (auctioned_property > 0) return "game_auction"; 
	if (selected_property > 0) return "game_upgrading_properties";
	if (rolling_dice == true) return "game_rolling_dice";
	if (game_waiting_to_roll == true)
	{
		if (players[player_turn].is_in_jail) 
		{
			if (players[player_turn].turns_in_jail < 3)
			{
				return "game_jail_waiting_to_roll";
			}
			else
			{
				return "game_jail_paying_fee";
			}
		}
		
		return "game_waiting_to_roll"; 
	}
	if (positions_remaining != 0) return "game_piece_moving";
	if (card_is_displayed == true) return "game_display_card";
	if (active_card != -1) return "game_card_in_action";
	if (property_purchased == false) return "game_purchasing_property";
	return "game_turn_end";
}

///@function game_state_is
///@param {String} type_
game_state_is = function(type_)
{
	var game_state = get_game_state();
	if (string_starts_with(game_state, type_))
	{
		return true;
	}
	return false;
}

///@function get_players_ready
get_players_ready = function()
{
	var count = 0;
	for (var i = 0; i < array_length(players); i++)
	{
		if (players[i].ready) count++;
	}
	return count;
}

///@function get_player_first_property
///@param {Real} player_index_
get_player_first_property = function(player_index_)
{
	var idx = player_index_;
	for (var i = 1; i <= 40; i++)
	{
		if (board[i].owner == players[idx].id)
		{
			return i;
		}
	}
	return 0;
}


///@function player
///@param {Real} id_
///@param {String} name_
player = function(id_, name_) constructor
{
	self.id = id_; 
	self.name = name_;
	self.money = 1500;
	self.jail_cards = 0;
	self.is_in_jail = false;
	self.turns_in_jail = 0;
	self.position = 1;
	self.target = 1;
	self.x = 0;
	self.y = 0;
	self.piece = array_shift(oGameHandler.player_pieces);
	self.color = array_shift(oGameHandler.player_colors);
	self.ready = false;
}

players = [];

///@function sync_players
sync_players = function()
{
	for (var i = 0; i < array_length(players); i++)
	{
		var p = players[i];
		var r = color_get_red(p.color);
		var g = color_get_green(p.color);
		var b = color_get_blue(p.color);
		packet_send(client.client, packet_create("hst_info_player_sync",
		[INT, STRING, INT, INT, BOOL, INT, INT, INT, INT, INT, STRING, U8, U8, U8, BOOL], 
		[p.id, p.name, p.money, p.jail_cards, p.is_in_jail, p.turns_in_jail, p.position,
		 p.target, p.x, p.y, p.piece, r, g, b, p.ready], 2));
	}
}

///@function put_player_in_jail
put_player_in_jail = function()
{
	players[player_turn].position = 11;
	players[player_turn].is_in_jail = true;
	game_waiting_to_roll = false;
}

///@function get_player_position
///@param {Real} player_index_
///@param {Real} board_index_
get_player_position = function(player_index_, board_index_)
{
	if (board[board_index_].shape != "square")
	{
		var hoff = floor(player_index_ / 3) - 0.5 ;
		var voff = (player_index_ % 3 ) - 1;
		var offset = board[board_index_].get_rotated_offset(board[board_index_].width / 2 + hoff * 64, 160 + voff * 64);
	
		return {x: board[board_index_].x + offset.x, 
				y: board[board_index_].y + offset.y};
	} else
	{
		if (board_index_ != 11)
		{
			var hoff = floor(player_index_ / 3) - 0.5 ;
			var voff = (player_index_ % 3 ) - 1;
			var offset = board[board_index_].get_rotated_offset(board[board_index_].width / 2 + hoff * 96, 128 + voff * 64);
	
			return {x: board[board_index_].x + offset.x, 
					y: board[board_index_].y + offset.y};
		}
		else
		{
			if (players[player_index_].is_in_jail)
			{
				var hoff = floor(player_index_ / 3) - 0.5 ;
				var voff = (player_index_ % 3 ) - 1;
				var offset = board[board_index_].get_rotated_offset(board[board_index_].width / 2 + 48 + hoff * 64, 80 + voff * 40);
	
				return {x: board[board_index_].x + offset.x, 
						y: board[board_index_].y + offset.y};
			}
			else
			{
				if (player_index_ < 3)
				{
					var off = player_index_ % 3;
					var offset = board[board_index_].get_rotated_offset(board[board_index_].width / 5, 48 + off * 48);
	
					return {x: board[board_index_].x + offset.x, 
							y: board[board_index_].y + offset.y};
				}
				else
				{
					var off = player_index_ % 3;
					var offset = board[board_index_].get_rotated_offset(128 + off * 48, 4 * board[board_index_].height / 5);
	
					return {x: board[board_index_].x + offset.x, 
							y: board[board_index_].y + offset.y};
				}
			}
		}
	}
}

///@function get_set_ownership
///@param {Real} player_id_
///@param {String} board_set_
get_set_ownership = function(player_id_, board_set_)
{
	var player_index_ = get_player_index_from_id(player_id_);
	var owned_number = 0;
	switch(board_set_)
	{
		case "railroad":
		if (board[6].owner == players[player_index_].id && !board[6].mortgaged) owned_number++;
		if (board[16].owner == players[player_index_].id && !board[16].mortgaged) owned_number++;
		if (board[26].owner == players[player_index_].id && !board[26].mortgaged) owned_number++;
		if (board[36].owner == players[player_index_].id && !board[36].mortgaged) owned_number++; 
		break;
		
		case "company":
		if (board[13].owner == players[player_index_].id && !board[13].mortgaged) owned_number++;
		if (board[29].owner == players[player_index_].id && !board[29].mortgaged) owned_number++;
		break;
		
		case "brown":
		if (board[2].owner == players[player_index_].id && !board[2].mortgaged) owned_number++;
		if (board[4].owner == players[player_index_].id && !board[4].mortgaged) owned_number++;
		break;
		
		case "lightblue":
		if (board[7].owner == players[player_index_].id && !board[7].mortgaged) owned_number++;
		if (board[9].owner == players[player_index_].id && !board[9].mortgaged) owned_number++;
		if (board[10].owner == players[player_index_].id && !board[10].mortgaged) owned_number++;
		break;
		
		case "pink":
		if (board[12].owner == players[player_index_].id && !board[12].mortgaged) owned_number++;
		if (board[14].owner == players[player_index_].id && !board[14].mortgaged) owned_number++;
		if (board[15].owner == players[player_index_].id && !board[15].mortgaged) owned_number++;
		break;
		
		case "orange":
		if (board[17].owner == players[player_index_].id && !board[17].mortgaged) owned_number++;
		if (board[19].owner == players[player_index_].id && !board[19].mortgaged) owned_number++;
		if (board[20].owner == players[player_index_].id && !board[20].mortgaged) owned_number++;
		break;
		
		case "red":
		if (board[22].owner == players[player_index_].id && !board[22].mortgaged) owned_number++;
		if (board[24].owner == players[player_index_].id && !board[24].mortgaged) owned_number++;
		if (board[25].owner == players[player_index_].id && !board[25].mortgaged) owned_number++;
		break;
		
		case "yellow":
		if (board[27].owner == players[player_index_].id && !board[27].mortgaged) owned_number++;
		if (board[28].owner == players[player_index_].id && !board[28].mortgaged) owned_number++;
		if (board[30].owner == players[player_index_].id && !board[30].mortgaged) owned_number++;
		break;
		
		case "green":
		if (board[32].owner == players[player_index_].id && !board[32].mortgaged) owned_number++;
		if (board[33].owner == players[player_index_].id && !board[33].mortgaged) owned_number++;
		if (board[35].owner == players[player_index_].id && !board[35].mortgaged) owned_number++;
		break;
		
		case "darkblue":
		if (board[38].owner == players[player_index_].id && !board[38].mortgaged) owned_number++;
		if (board[40].owner == players[player_index_].id && !board[40].mortgaged) owned_number++;
		break;
		
		default:
		break;
	}
	return owned_number;
}

///@function is_set
///@param {String} board_set_
is_set = function(board_set_)
{
	switch(board_set_)
	{
		case "brown":
		if (board[2].mortgaged) return false;
		if (board[4].mortgaged) return false;
		if (is_undefined(board[2].owner)) return false;
		if (board[2].owner != board[4].owner) return false;
		return true;
		
		case "lightblue":
		if (board[7].mortgaged) return false;
		if (board[9].mortgaged) return false;
		if (board[10].mortgaged) return false;
		if (is_undefined(board[7].owner)) return false;
		if (board[7].owner != board[9].owner) return false;
		if (board[7].owner != board[10].owner) return false;
		return true;
		
		case "pink":
		if (board[12].mortgaged) return false;
		if (board[14].mortgaged) return false;
		if (board[15].mortgaged) return false;
		if (is_undefined(board[12].owner)) return false;
		if (board[12].owner != board[14].owner) return false;
		if (board[12].owner != board[15].owner) return false;
		return true;
		
		case "orange":
		if (board[17].mortgaged) return false;
		if (board[19].mortgaged) return false;
		if (board[20].mortgaged) return false;
		if (is_undefined(board[17].owner)) return false;
		if (board[17].owner != board[19].owner) return false;
		if (board[17].owner != board[20].owner) return false;
		return true;
		
		case "red":
		if (board[22].mortgaged) return false;
		if (board[24].mortgaged) return false;
		if (board[25].mortgaged) return false;
		if (is_undefined(board[22].owner)) return false;
		if (board[22].owner != board[24].owner) return false;
		if (board[22].owner != board[25].owner) return false;
		return true;
		
		case "yellow":
		if (board[27].mortgaged) return false;
		if (board[28].mortgaged) return false;
		if (board[30].mortgaged) return false;
		if (is_undefined(board[27].owner)) return false;
		if (board[27].owner != board[28].owner) return false;
		if (board[27].owner != board[30].owner) return false;
		return true;
		
		case "green":
		if (board[32].mortgaged) return false;
		if (board[33].mortgaged) return false;
		if (board[35].mortgaged) return false;
		if (is_undefined(board[32].owner)) return false;
		if (board[32].owner != board[33].owner) return false;
		if (board[32].owner != board[35].owner) return false;
		return true;
		
		case "darkblue":
		if (board[38].mortgaged) return false;
		if (board[40].mortgaged) return false;
		if (is_undefined(board[38].owner)) return false;
		if (board[38].owner != board[40].owner) return false;
		return true;
		
		default:
		return false;
	}
}

///@function can_trade
///@param {Real} board_index_
can_trade = function(board_index_)
{
	if (board[board_index_].set == "railroad") return true;
	if (board[board_index_].set == "company")  return true;
	if (board[board_index_].type != "property") return false;
	
	for (var i = 1; i <= 40; i++)
	{
		if (board[i].set == board[board_index_].set)
		{
			if (board[i].upgrade_state > 1) return false;
		}
	}
	return true;
}

///@function can_upgrade_property
///@param {Real} board_index_
can_upgrade_property = function(board_index_)
{
	if (board[board_index_].upgrade_state >= 6)
	{
		return false;
	}
	if (board[board_index_].mortgaged == true)
	{
		return true;
	}
	if (board[board_index_].upgradeable == false)
	{
		return false;
	}
	else if (is_set(board[board_index_].set))
	{
		var min_upgrade = board[board_index_].upgrade_state;
		for (var i = 1; i <= 40; i++)
		{
			if (board[i].set == board[board_index_].set && board[i].upgrade_state < min_upgrade)
			{
				min_upgrade = board[i].upgrade_state;
			}
		}
		if (board[board_index_].upgrade_state <= min_upgrade)
		{
			return true;
		}
	}
	return false;
}

///@function can_downgrade_property
///@param {Real} board_index_
can_downgrade_property = function(board_index_)
{
	if (board[board_index_].mortgaged == true)
	{
		return false;
	}
	else if (is_set(board[board_index_].set))
	{
		var max_upgrade = board[board_index_].upgrade_state;
		for (var i = 1; i <= 40; i++)
		{
			if (board[i].set == board[board_index_].set && board[i].upgrade_state > max_upgrade)
			{
				max_upgrade = board[i].upgrade_state;
			}
		}
		if (board[board_index_].upgrade_state >= max_upgrade)
		{
			return true;
		}
		return false;
	}
	
	return true;
}

///@function update_board_sets
function update_board_sets()
{
	#region Properties
	
	#region Browns
	if (board[2].mortgaged || board[4].mortgaged)
	{
		board[2].upgrade_state = 0;
		board[4].upgrade_state = 0;
	}
	
	if(is_set("brown"))
	{
		if (board[2].upgrade_state == 0)
		{
			board[2].upgrade_state = 1;
			board[4].upgrade_state = 1;
		}
	}
	else
	{
		board[2].upgrade_state = 0;
		board[4].upgrade_state = 0;
	}
	#endregion
	
	#region Lightblues
	if (board[7].mortgaged || board[9].mortgaged || board[10].mortgaged)
	{
		board[7].upgrade_state = 0;
		board[9].upgrade_state = 0;
		board[10].upgrade_state = 0;
	}
	
	if(is_set("lightblue"))
	{
		if (board[7].upgrade_state == 0)
		{
			board[7].upgrade_state = 1;
			board[9].upgrade_state = 1;
			board[10].upgrade_state = 1;
		}
	}
	else
	{
		board[7].upgrade_state = 0;
		board[9].upgrade_state = 0;
		board[10].upgrade_state = 0;
	}
	#endregion
	
	#region Pinks
	if (board[12].mortgaged || board[14].mortgaged || board[15].mortgaged)
	{
		board[12].upgrade_state = 0;
		board[14].upgrade_state = 0;
		board[15].upgrade_state = 0;
	}
	
	if(is_set("pink"))
	{
		if (board[12].upgrade_state == 0)
		{
			board[12].upgrade_state = 1;
			board[14].upgrade_state = 1;
			board[15].upgrade_state = 1;
		}
	}
	else
	{
		board[12].upgrade_state = 0;
		board[14].upgrade_state = 0;
		board[15].upgrade_state = 0;
	}
	#endregion
	
	#region Oranges
	if (board[17].mortgaged || board[17].mortgaged || board[20].mortgaged)
	{
		board[17].upgrade_state = 0;
		board[19].upgrade_state = 0;
		board[20].upgrade_state = 0;
	}
	
	if(is_set("orange"))
	{
		if (board[17].upgrade_state == 0)
		{
			board[17].upgrade_state = 1;
			board[19].upgrade_state = 1;
			board[20].upgrade_state = 1;
		}
	}
	else
	{
		board[17].upgrade_state = 0;
		board[19].upgrade_state = 0;
		board[20].upgrade_state = 0;
	}
	#endregion
	
	#region Reds
	if (board[22].mortgaged || board[24].mortgaged || board[25].mortgaged)
	{
		board[22].upgrade_state = 0;
		board[24].upgrade_state = 0;
		board[25].upgrade_state = 0;
	}
	
	if(is_set("red"))
	{
		if (board[22].upgrade_state == 0)
		{
			board[22].upgrade_state = 1;
			board[24].upgrade_state = 1;
			board[25].upgrade_state = 1;
		}
	}
	else
	{
		board[22].upgrade_state = 0;
		board[24].upgrade_state = 0;
		board[25].upgrade_state = 0;
	}
	#endregion
	
	#region Yellows
	if (board[27].mortgaged || board[28].mortgaged || board[30].mortgaged)
	{
		board[27].upgrade_state = 0;
		board[28].upgrade_state = 0;
		board[30].upgrade_state = 0;
	}
	
	if(is_set("yellow"))
	{
		if (board[27].upgrade_state == 0)
		{
			board[27].upgrade_state = 1;
			board[28].upgrade_state = 1;
			board[30].upgrade_state = 1;
		}
	}
	else
	{
		board[27].upgrade_state = 0;
		board[28].upgrade_state = 0;
		board[30].upgrade_state = 0;
	}
	#endregion
	
	#region Greens
	if (board[32].mortgaged || board[33].mortgaged || board[35].mortgaged)
	{
		board[32].upgrade_state = 0;
		board[33].upgrade_state = 0;
		board[35].upgrade_state = 0;
	}
	
	if(is_set("green"))
	{
		if (board[32].upgrade_state == 0)
		{
			board[32].upgrade_state = 1;
			board[33].upgrade_state = 1;
			board[35].upgrade_state = 1;
		}
	}
	else
	{
		board[32].upgrade_state = 0;
		board[33].upgrade_state = 0;
		board[35].upgrade_state = 0;
	}
	#endregion
	
	#region Darkblues
	if (board[38].mortgaged || board[40].mortgaged)
	{
		board[38].upgrade_state = 0;
		board[40].upgrade_state = 0;
	}
	
	if(is_set("darkblue"))
	{
		if (board[38].upgrade_state == 0)
		{
			board[38].upgrade_state = 1;
			board[40].upgrade_state = 1;
		}
	}
	else
	{
		board[38].upgrade_state = 0;
		board[40].upgrade_state = 0;
	}
	#endregion
	
	#endregion
	
	#region Railroads

	board[6].upgrade_state = 0;
	board[16].upgrade_state = 0;
	board[26].upgrade_state = 0;
	board[36].upgrade_state = 0;
	if (!is_undefined(board[6].owner))
	{
		board[6].upgrade_state = get_set_ownership(board[6].owner, board[6].set);
	}
	
	if (!is_undefined(board[16].owner))
	{
		board[16].upgrade_state = get_set_ownership(board[16].owner, board[16].set);
	}
	
	if (!is_undefined(board[26].owner))
	{
		board[26].upgrade_state = get_set_ownership(board[26].owner, board[26].set);
	}
	
	if (!is_undefined(board[36].owner))
	{
		board[36].upgrade_state = get_set_ownership(board[36].owner, board[36].set);
	}

	#endregion

	#region Companies
	
	board[13].upgrade_state = 0;
	board[29].upgrade_state = 0;
	if (!is_undefined(board[13].owner))
	{
		if (get_set_ownership(board[13].owner, "company") == 1 && board[13].mortgaged == false)
		{
			board[13].upgrade_state = 4;
		}
		else if (get_set_ownership(board[13].owner, "company") == 2)
		{
			board[13].upgrade_state = 10;
		}
	}
	
	if (!is_undefined(board[29].owner))
	{
		if (get_set_ownership(board[29].owner, "company") == 1 && board[29].mortgaged == false)
		{
			board[29].upgrade_state = 4;
		}
		else if (get_set_ownership(board[29].owner, "company") == 2)
		{
			board[29].upgrade_state = 10;
		}
	}
	
	#endregion
}

#region board_space constructor
///@function board_space
///@param {String} type_
///@param {String} name_
///@param {String} shape_
///@param {Real} price_
///@param {Bool} upgradeable_
///@param {Real} upgrade_cost_
///@param {Array<Real>} rent_
///@param {Real} x_
///@param {Real} y_
///@param {Real} rotation_
///@param {String} set_
#endregion
board_space = function(type_, name_, shape_, price_ = 0, upgradeable_ = false, upgrade_cost_ = 0, rent_ = [], x_ = 0, y_ = 0, rotation_ = 0, set_ = "") constructor
{
	self.type = type_;
	self.name = name_;
	self.owner = undefined;
	self.price = price_;
	self.upgradeable = upgradeable_;
	self.upgrade_state = 0; 
	self.upgrade_cost = upgrade_cost_;
	self.rent = rent_;
	self.shape = shape_;
	self.x = x_;
	self.y = y_;
	self.width = 128;
	self.height = 256;
	self.rotation = rotation_;
	self.set = set_;
	self.mortgaged = false;
	
	///@function get_rotated_offset
	static get_rotated_offset = function(xx_, yy_)
	{
		//Love doing math on an inverted y axis :)
		yy_ = -yy_;
		var angle = self.rotation * pi / 180;
		var offx = xx_ * cos(angle) - yy_ * sin(angle);
		var offy = xx_ * sin(angle) + yy_ * cos(angle);
		return {x : offx, y : -offy};
	};
}


board = [];
board[1] = new board_space("go", "go", "square",,,,, 1408, 1408);
board[2] = new board_space("property", "brown 1", "vertical", 60, true, 50, [2, 4, 10, 30, 90, 160, 250], 1280, 1408, 0, "brown");
board[3] = new board_space("chest", "community chest", "vertical",,,,, 1152, 1408, 0);
board[4] = new board_space("property", "brown 2", "vertical", 60, true, 50, [4, 8, 20, 60, 180, 320, 450], 1024, 1408, 0, "brown");
board[5] = new board_space("income_tax", "income tax", "vertical",,,,, 896, 1408, 0);
board[6] = new board_space("railroad", "railroad 1", "vertical", 200,,,, 768, 1408, 0, "railroad");
board[7] = new board_space("property", "lightblue 1", "vertical", 100, true, 50, [6, 12, 30, 90, 270, 400, 550], 640, 1408, 0, "lightblue");
board[8] = new board_space("chance", "chance", "vertical",,,,, 512, 1408, 0);
board[9] = new board_space("property", "lightblue 2", "vertical", 100, true, 50, [6, 12, 30, 90, 270, 400, 550], 384, 1408, 0, "lightblue");
board[10] = new board_space("property", "lightblue 3", "vertical", 120, true, 50, [8, 16, 40, 100, 300, 450, 600], 256, 1408, 0, "lightblue");
board[11] = new board_space("jail", "jail", "square",,,,, 0, 1408);
board[12] = new board_space("property", "pink 1", "horizontal", 140, true, 100, [10, 20, 50, 150, 450, 625, 750], 256, 1280, -90, "pink");
board[13] = new board_space("company", "electric company", "horizontal", 150,,,, 256, 1152, -90, "company");
board[14] = new board_space("property", "pink 2", "horizontal", 140, true, 100, [10, 20, 50, 150, 450, 625, 750], 256, 1024, -90, "pink");
board[15] = new board_space("property", "pink 3", "horizontal", 160, true, 100, [12, 24, 60, 180, 500, 700, 900], 256, 896, -90,"pink"); 
board[16] = new board_space("railroad", "railroad 2", "horizontal", 200,,,, 256, 768, -90, "railroad");
board[17] = new board_space("property", "orange 1", "horizontal", 180, true, 100, [14, 28, 70, 200, 550, 750, 950], 256, 640, -90,"orange");
board[18] = new board_space("chest", "community chest", "horizontal",,,,, 256, 512, -90);
board[19] = new board_space("property", "orange 2", "horizontal", 180, true, 100, [14, 28, 70, 200, 550, 750, 950], 256, 384, -90,"orange");
board[20] = new board_space("property", "orange 3", "horizontal", 200, true, 100, [16, 32, 80, 220, 600, 800, 1000], 256, 256, -90,"orange");
board[21] = new board_space("free_parking", "free parking", "square",,,,, 256, 256, 180);
board[22] = new board_space("property", "red 1", "vertical", 220, true, 150, [18, 36, 90, 250, 700, 875, 1050], 384, 256, 180,"red");
board[23] = new board_space("chance", "chance", "vertical",,,,, 512, 256, 180);
board[24] = new board_space("property", "red 2", "vertical", 220, true, 150, [18, 36, 90, 250, 700, 875, 1050], 640, 256, 180, "red");
board[25] = new board_space("property", "red 3", "vertical", 240, true, 150, [20, 40, 100, 300, 750, 925, 1100], 768, 256, 180, "red");
board[26] = new board_space("railroad", "railroad 3", "vertical", 200,,,, 896, 256, 180, "railroad");
board[27] = new board_space("property", "yellow 1", "vertical", 260, true, 150, [22, 44, 110, 330, 800, 975, 1150], 1024, 256, 180, "yellow");
board[28] = new board_space("property", "yellow 2", "vertical", 260, true, 150, [22, 44, 110, 330, 800, 975, 1150], 1152, 256, 180, "yellow");
board[29] = new board_space("company", "water company", "vertical", 150,,,, 1280, 256, 180, "company");
board[30] = new board_space("property", "yellow 3", "vertical", 280, true, 150, [24, 48, 120, 360, 850, 1025, 1200], 1408, 256, 180, "yellow");
board[31] = new board_space("to_jail", "go to jail", "square",,,,, 1408, 256, 90);
board[32] = new board_space("property", "green 1", "horizontal", 300, true, 200, [26, 52, 130, 390, 900, 1100, 1275], 1408, 384, 90, "green");
board[33] = new board_space("property", "green 2", "horizontal", 300, true, 200, [26, 52, 130, 390, 900, 1100, 1275], 1408, 512, 90, "green");
board[34] = new board_space("chest", "community chest", "horizontal",,,,, 1408, 640, 90);
board[35] = new board_space("property", "green 3", "horizontal", 320, true, 200, [28, 56, 150, 420, 900, 1200, 1400], 1408, 768, 90, "green");
board[36] = new board_space("railroad", "railroad 4", "horizontal", 200,,,, 1408, 896, 90, "railroad");
board[37] = new board_space("chance", "chance", "horizontal",,,,, 1408, 1024, 90);
board[38] = new board_space("property", "darkblue 1", "horizontal", 350, true, 200, [35, 70, 175, 500, 1100, 1300, 1500], 1408, 1152, 90, "darkblue");
board[39] = new board_space("luxury_tax", "luxury tax", "horizontal",,,,, 1408, 1280, 90);
board[40] = new board_space("property", "darkblue 2", "horizontal", 400, true, 200, [50, 100, 200, 600, 1400, 1700, 2000], 1408, 1408, 90, "darkblue");

board[1].width = 256;
board[11].width = 256;
board[21].width = 256;
board[31].width = 256;