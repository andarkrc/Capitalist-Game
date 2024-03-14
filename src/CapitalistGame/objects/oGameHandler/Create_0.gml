game_started = false;
game_starting = false;
game_starting_time = 1;
game_starting_counter = 0;
players_ready = 0;
player_turn = 0;


if (global.connection_type == "server")
{
	instance_create_layer(0, 0, "Instances", oServerHandler);
}
instance_create_layer(0, 0, "Instances", oClientHandler);


events = [];


player_colors = [c_blue, c_green, c_red, c_purple, c_aqua, c_yellow, c_orange, c_lime, c_fuchsia, c_teal];
player_pieces = ["Bike", "Cat", "Dog", "Duck", "Potato", "Rat"];

#region Time Sources
var fn = function(){
	if (game_starting_counter > 0) 
	{
		game_starting_counter--;
	}
	if (game_starting_counter == 0)
	{
		game_starting = false;
		game_started = true;
		instance_create_layer(0, 0, "Instances", oCamera);
	}
}
game_starting_ts = time_source_create(time_source_game, 1, time_source_units_seconds, fn, [], game_starting_time);
#endregion





///@function get_game_state
get_game_state = function(){
	if (game_starting == true) return "lobby_starting";
	if (game_started == false) return "lobby";
	return "game";
}

///@function game_state_is
///@param {String} type_
game_state_is = function(type_){
	var game_state = get_game_state();
	if (type_ == "game")
	{
		switch(game_state)
		{
			case "game" :
			return true;
			
			default :
			return false;
		}
	}
	if (type_ == "lobby")
	{
		switch(game_state)
		{
			case "lobby":
			case "lobby_starting":
			return true;
			
			default:
			return false;
		}
	}
	return false;
}

///@function get_players_ready
get_players_ready = function(){
	var count = 0;
	for (var i = 0; i < array_length(players); i++)
	{
		if (players[i].ready) count++;
	}
	return count;
}




#region player constructor
///@function player
///@param {Real} id_
///@param {Real} money_
///@param {String} name_
///@param {String} piece_
///@param {Constant.Color} color_
#endregion
player = function(id_, money_ = 15000, name_ = "", piece_ = "", color_ = c_white) constructor{
	self.id = id_; 
	self.name = name_;
	self.money = money_;
	self.jail_cards = 0;
	self.is_in_jail = false;
	self.turns_in_jail = 0;
	self.position = 1;
	self.piece = piece_;
	self.color = color_;
	self.ready = false;
}

players = [];

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
board_space = function(type_, name_, shape_, price_ = 0, upgradeable_ = false, upgrade_cost_ = 0, rent_ = [], x_ = 0, y_ = 0, rotation_ = 0, set_ = "") constructor{
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
	self.rotation = rotation_;
	self.set = set_;
	self.mortgaged = false;
}


board = [];
board[1] = new board_space("go", "go", "square",,,,, 1408, 1408);
board[2] = new board_space("property", "brown 1", "vertical", 60, true, 50, [2, 4, 10, 30, 90, 160, 250], 1280, 1408, 0, "brown");
board[3] = new board_space("chest", "community chest", "vertical",,,,, 1152, 1408, 0);
board[4] = new board_space("property", "brown 2", "vertical", 60, true, 50, [4, 8, 20, 60, 180, 320, 450], 1024, 1408, 0, "brown");
board[5] = new board_space("income_tax", "income tax", "vertical",,,,, 896, 1408, 0);
board[6] = new board_space("railroad", "railroad 1", "vertical", 200,,,, 768, 1408, 0);
board[7] = new board_space("property", "lightblue 1", "vertical", 100, true, 50, [6, 12, 30, 90, 270, 400, 550], 640, 1408, 0, "lightblue");
board[8] = new board_space("chance", "chance", "vertical",,,,, 512, 1408, 0);
board[9] = new board_space("property", "lightblue 2", "vertical", 100, true, 50, [6, 12, 30, 90, 270, 400, 550], 384, 1408, 0, "lightblue");
board[10] = new board_space("property", "lightblue 3", "vertical", 120, true, 50, [8, 16, 40, 100, 300, 450, 600], 256, 1408, 0, "lightblue");
board[11] = new board_space("jail", "jail", "square",,,,, 0, 1408);
board[12] = new board_space("property", "pink 1", "horizontal", 140, true, 100, [10, 20, 50, 150, 450, 625, 750], 256, 1280, -90, "pink");
board[13] = new board_space("company", "electric company", "horizontal", 150,,,, 256, 1152, -90);
board[14] = new board_space("property", "pink 2", "horizontal", 140, true, 100, [10, 20, 50, 150, 450, 625, 750], 256, 1024, -90, "pink");
board[15] = new board_space("property", "pink 3", "horizontal", 160, true, 100, [12, 24, 60, 180, 500, 700, 900], 256, 896, -90,"pink"); 
board[16] = new board_space("railroad", "railroad 2", "horizontal", 200,,,, 256, 768, -90);
board[17] = new board_space("property", "orange 1", "horizontal", 180, true, 100, [14, 28, 70, 200, 550, 750, 950], 256, 640, -90,"orange");
board[18] = new board_space("chest", "community chest", "horizontal",,,,, 256, 512, -90);
board[19] = new board_space("property", "orange 2", "horizontal", 180, true, 100, [14, 28, 70, 200, 550, 750, 950], 256, 384, -90,"orange");
board[20] = new board_space("property", "orange 3", "horizontal", 200, true, 100, [16, 32, 80, 220, 600, 800, 1000], 256, 256, -90,"orange");
board[21] = new board_space("free_parking", "free parking", "square",,,,, 256, 256, 180);
board[22] = new board_space("property", "red 1", "vertical", 220, true, 150, [18, 36, 90, 250, 700, 875, 1050], 384, 256, 180,"red");
board[23] = new board_space("chance", "chance", "vertical",,,,, 512, 256, 180);
board[24] = new board_space("property", "red 2", "vertical", 220, true, 150, [18, 36, 90, 250, 700, 875, 1050], 640, 256, 180, "red");
board[25] = new board_space("property", "red 3", "vertical", 240, true, 150, [20, 40, 100, 300, 750, 925, 1100], 768, 256, 180, "red");
board[26] = new board_space("railroad", "railroad 3", "vertical", 200,,,, 896, 256, 180);
board[27] = new board_space("property", "yellow 1", "vertical", 260, true, 150, [22, 44, 110, 330, 800, 975, 1150], 1024, 256, 180, "yellow");
board[28] = new board_space("property", "yellow 2", "vertical", 260, true, 150, [22, 44, 110, 330, 800, 975, 1150], 1152, 256, 180, "yellow");
board[29] = new board_space("company", "water company", "vertical", 150,,,, 1280, 256, 180);
board[30] = new board_space("property", "yellow 3", "vertical", 280, true, 150, [24, 48, 120, 360, 850, 1025, 1200], 1408, 256, 180, "yellow");
board[31] = new board_space("to_jail", "go to jail", "square",,,,, 1408, 256, 90);
board[32] = new board_space("property", "green 1", "horizontal", 300, true, 200, [26, 52, 130, 390, 900, 1100, 1275], 1408, 384, 90, "green");
board[33] = new board_space("property", "green 2", "horizontal", 300, true, 200, [26, 52, 130, 390, 900, 1100, 1275], 1408, 512, 90, "green");
board[34] = new board_space("chest", "community chest", "horizontal",,,,, 1408, 640, 90);
board[35] = new board_space("property", "green 3", "horizontal", 320, true, 200, [28, 56, 150, 420, 900, 1200, 1400], 1408, 768, 90, "green");
board[36] = new board_space("railroad", "railroad 4", "horizontal", 200,,,, 1408, 896, 90);
board[37] = new board_space("chance", "chance", "horizontal",,,,, 1408, 1024, 90);
board[38] = new board_space("property", "darkblue 1", "horizontal", 350, true, 200, [35, 70, 175, 500, 1100, 1300, 1500], 1408, 1152, 90, "darkblue");
board[39] = new board_space("luxury_tax", "luxury tax", "horizontal",,,,, 1408, 1280, 90);
board[40] = new board_space("property", "darkblue 2", "horizontal", 400, true, 200, [50, 100, 200, 600, 1400, 1700, 2000], 1408, 1408, 90, "darkblue");
