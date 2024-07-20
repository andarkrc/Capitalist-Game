var players = oGameHandler.players;
var player_turn = oGameHandler.player_turn;
var board = oGameHandler.board;

if (oGameHandler.get_game_state() != "game_upgrading_properties")
{
	if (players[player_turn].position % 10 == 1 || players[player_turn].target % 10 == 1)
	{
		var midx = sprite_get_width(sBoard) / 2;
		var midy = sprite_get_height(sBoard) / 2;
		var dir = point_direction(midx, midy, players[player_turn].x, players[player_turn].y);
	
		x = midx + (midx * 1.4) * dcos(dir);
		y = midy - (midy * 1.4) * dsin(dir);
	
		var index = players[player_turn].position;
		var offset_to = board[index].get_rotated_offset(0, -128);
	
		x_lookat = players[player_turn].x + offset_to.x;
		y_lookat = players[player_turn].y + offset_to.y;
	}
	else
	{
		var index = players[player_turn].position;
		var offset_from = board[index].get_rotated_offset(0, 192);
		var offset_to = board[index].get_rotated_offset(0, -128);
		x = players[player_turn].x + offset_from.x;
		y = players[player_turn].y + offset_from.y;
	
		x_lookat = players[player_turn].x + offset_to.x;
		y_lookat = players[player_turn].y + offset_to.y;
	}
}
else
{
	var index = oGameHandler.selected_property;
	var offset_from = board[index].get_rotated_offset(board[index].width /2 , 192);
	var offset_to = board[index].get_rotated_offset(board[index].width / 2, -128);
	x = board[index].x + offset_from.x;
	y = board[index].y + offset_from.y;
	
	x_lookat = board[index].x + offset_to.x;
	y_lookat = board[index].y + offset_to.y;
}