game_started = false;
game_starting = false;
game_starting_counter = 0;
player_colors = [c_blue, c_green, c_red, c_purple, c_aqua, c_yellow, c_orange, c_lime, c_fuchsia, c_teal];
player_pieces = ["Bike", "Cat", "Dog", "Duck", "Potato", "Rat"];
players_ready = 0;
player_turn = 1;
player_turn_ready = false;
dice_rolling = false;
dice1 = 0;
dice2 = 2;
vdice = 0;
spaces_left = 0;
player_current_x = 0;
player_current_y = 0;
player_payed_rent = false;
my_player_id = -1;
player_has_property = false; 
player_go_money_collected = false;
card_displayed = false;
card_index = -1;
card_collected = false;
card_type = "";
community_chest_cards = ["collect_100", "pay_50", "collect_25", "property_repairs", "go_to_jail", "go_to_go", "collect_200", "pay_150", "collect_50", "collect_10", "pay_100", "jail_card", "collect_20", "collect_50_from_players"];
chance_cards = ["go_to_go", "pay_15", "go_to_railroad1", "collect_50", "go_to_jail", "pay_50_to_players", "go_to_red3", "go_to_nearest_company", "go_to_nearest_railroad", "jail_card", "go_back_3_spaces", "property_repairs", "collect_100", "go_to_darkblue2", "go_to_pink1"];
card_effect = false;
auction_active = false;
auction_players = [];
auction_turn = 0;
auction_value = 0;
last_bid = 0;
last_bidder = "Capitalist Bank";
can_bid = true;
property_upgrade_active = false;
property_upgrade_index = 1;
can_upgrade = true;
trade_active = false;
trade_sent = false;
trade_party1 = [];
trade_party2 = [];
trade_money1 = 0;
trade_money2 = 0;
trader1 = -1;
trader2 = -1;
key_press_enter = false;
key_press_space = false;
key_press_backspace = false;
key_press_a = false;
key_press_d = false;


events = [];

if(global.connection_type == "server")
{
	instance_create_layer(0, 0, "Instances", oServerHandler);
}
else
{
	instance_create_layer(0, 0, "Instances", oClientHandler);
}

var fn = function(){
	if(oGameHandler.game_starting_counter > 0)
	{
		oGameHandler.game_starting_counter--;
	}
	else
	{
		instance_create_layer(room_width/2, room_height/2, "Instances", oCamera);
		oGameHandler.game_started = true;
		oGameHandler.game_starting = false;
	}
}

ts_game_starting_counter = time_source_create(time_source_game, 1, time_source_units_seconds, fn, [], -1);

fn = function(){
	dice_rolling = false;
	for(var i = 0; i < array_length(players); i++)
	{
		players[i].player_sold_property = false;
	}
	if(!players[player_turn-1].is_in_jail || dice1 == dice2)
	{
		spaces_left = dice1 + dice2;
		var pos = oCamera.get_player_xy_from_position(players[player_turn-1].position, player_turn-1);
		player_current_x = board[players[player_turn-1].position].xx1 + 12 + pos.x;
		player_current_y = board[players[player_turn-1].position].yy1 + 24 + pos.y;
		players[player_turn-1].is_in_jail = false;
		players[player_turn-1].turns_in_jail = 0;
	}
	else
	{
		players[player_turn-1].turns_in_jail++;
		player_turn_ready = true;
	}
}

ts_dice_rolling = time_source_create(time_source_game, 1, time_source_units_seconds, fn);

fn = function(){
	oGameHandler.card_displayed = false;
}

ts_card_display = time_source_create(time_source_game, 2, time_source_units_seconds, fn);

///@function player
///@param {Real} id_
///@param {Real} money_
///@param {String} piece_
///@param {Constant.Color} color_
player = function(id_, money_ = 15000, piece_ = "", color_ = c_white) constructor{
	self.id = id_; 
	self.name = "";
	self.money = money_;
	self.jail_cards = 0;
	self.is_in_jail = false;
	self.turns_in_jail = 0;
	self.position = 1;
	self.piece = piece_;
	self.color = color_;
	self.ready = false;
	self.player_sold_property = false;
}

///@function board_space
///@param {String} type_
///@param {String} name_
///@param {String} shape_
///@param {Real} price_
///@param {Bool} upgradeable_
///@param {Real} upgrade_cost_
///@param {Array<Real>} rent_
///@param {Real} xx1_
///@param {Real} yy1_
///@param {String} set_
board_space = function(type_, name_, shape_, price_ = 0, upgradeable_ = false, upgrade_cost_ = 0, rent_ = [], xx1_ = 0, yy1_ = 0, set_ = "") constructor{
	self.type = type_;
	self.name = name_;
	self.owner = undefined;
	self.price = price_;
	self.upgradeable = upgradeable_;
	self.upgrade_state = 0; 
	self.upgrade_cost = upgrade_cost_;
	self.rent = rent_;
	self.shape = shape_;
	self.xx1 = xx1_;
	self.yy1 = yy1_;
	self.set = set_;
}
players = [];

///@function place_player_in_jail
///@param {Real} id_
place_player_in_jail = function(id_){
	var index = getPlayerIndexFromID(id_);
	players[index].is_in_jail = true;
	players[index].position = 11;
}


board = [];
board[1] = new board_space("go", "go", "square",,,,, 1408, 1408);
board[2] = new board_space("property", "brown 1", "vertical", 60, true, 50, [2, 4, 10, 30, 90, 160, 250], 1280, 1408, "brown");
board[3] = new board_space("chest", "community chest", "vertical",,,,, 1152, 1408);
board[4] = new board_space("property", "brown 2", "vertical", 60, true, 50, [4, 8, 20, 60, 180, 320, 450], 1024, 1408, "brown");
board[5] = new board_space("income_tax", "income tax", "vertical",,,,, 896, 1408);
board[6] = new board_space("railroad", "railroad 1", "vertical", 200,,,, 768, 1408);
board[7] = new board_space("property", "lightblue 1", "vertical", 100, true, 50, [6, 12, 30, 90, 270, 400, 550], 640, 1408, "lightblue");
board[8] = new board_space("chance", "chance", "vertical",,,,, 512, 1408);
board[9] = new board_space("property", "lightblue 2", "vertical", 100, true, 50, [6, 12, 30, 90, 270, 400, 550], 384, 1408, "lightblue");
board[10] = new board_space("property", "lightblue 3", "vertical", 120, true, 50, [8, 16, 40, 100, 300, 450, 600], 256, 1408, "lightblue");
board[11] = new board_space("jail", "jail", "square",,,,, 0, 1408);
board[12] = new board_space("property", "pink 1", "horizontal", 140, true, 100, [10, 20, 50, 150, 450, 625, 750], 0, 1280, "pink");
board[13] = new board_space("company", "electric company", "horizontal", 150,,,, 0, 1152);
board[14] = new board_space("property", "pink 2", "horizontal", 140, true, 100, [10, 20, 50, 150, 450, 625, 750], 0, 1024, "pink");
board[15] = new board_space("property", "pink 3", "horizontal", 160, true, 100, [12, 24, 60, 180, 500, 700, 900], 0, 896, "pink"); 
board[16] = new board_space("railroad", "railroad 2", "horizontal", 200,,,, 0, 768);
board[17] = new board_space("property", "orange 1", "horizontal", 180, true, 100, [14, 28, 70, 200, 550, 750, 950], 0, 640, "orange");
board[18] = new board_space("chest", "community chest", "horizontal",,,,, 0, 512);
board[19] = new board_space("property", "orange 2", "horizontal", 180, true, 100, [14, 28, 70, 200, 550, 750, 950], 0, 384, "orange");
board[20] = new board_space("property", "orange 3", "horizontal", 200, true, 100, [16, 32, 80, 220, 600, 800, 1000], 0, 256, "orange");
board[21] = new board_space("free_parking", "free parking", "square",,,,, 0, 0);
board[22] = new board_space("property", "red 1", "vertical", 220, true, 150, [18, 36, 90, 250, 700, 875, 1050], 256, 0, "red");
board[23] = new board_space("chance", "chance", "vertical",,,,, 384, 0);
board[24] = new board_space("property", "red 2", "vertical", 220, true, 150, [18, 36, 90, 250, 700, 875, 1050], 512, 0, "red");
board[25] = new board_space("property", "red 3", "vertical", 240, true, 150, [20, 40, 100, 300, 750, 925, 1100], 640, 0, "red");
board[26] = new board_space("railroad", "railroad 3", "vertical", 200,,,, 768, 0);
board[27] = new board_space("property", "yellow 1", "vertical", 260, true, 150, [22, 44, 110, 330, 800, 975, 1150], 896, 0, "yellow");
board[28] = new board_space("property", "yellow 2", "vertical", 260, true, 150, [22, 44, 110, 330, 800, 975, 1150], 1024, 0, "yellow");
board[29] = new board_space("company", "water company", "vertical", 150,,,, 1152, 0);
board[30] = new board_space("property", "yellow 3", "vertical", 280, true, 150, [24, 48, 120, 360, 850, 1025, 1200], 1280, 0, "yellow");
board[31] = new board_space("to_jail", "go to jail", "square",,,,, 1408, 0);
board[32] = new board_space("property", "green 1", "horizontal", 300, true, 200, [26, 52, 130, 390, 900, 1100, 1275], 1408, 256, "green");
board[33] = new board_space("property", "green 2", "horizontal", 300, true, 200, [26, 52, 130, 390, 900, 1100, 1275], 1408, 384, "green");
board[34] = new board_space("chest", "community chest", "horizontal",,,,, 1408, 512);
board[35] = new board_space("property", "green 3", "horizontal", 320, true, 200, [28, 56, 150, 420, 900, 1200, 1400], 1408, 640, "green");
board[36] = new board_space("railroad", "railroad 4", "horizontal", 200,,,, 1408, 768);
board[37] = new board_space("chance", "chance", "horizontal",,,,, 1408, 896);
board[38] = new board_space("property", "darkblue 1", "horizontal", 350, true, 200, [35, 70, 175, 500, 1100, 1300, 1500], 1408, 1024, "darkblue");
board[39] = new board_space("luxury_tax", "luxury tax", "horizontal",,,,, 1408, 1152);
board[40] = new board_space("property", "darkblue 2", "horizontal", 400, true, 200, [50, 100, 200, 600, 1400, 1700, 2000], 1408, 1280, "darkblue");
