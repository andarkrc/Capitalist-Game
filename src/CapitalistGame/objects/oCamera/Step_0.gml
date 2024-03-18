var players = oGameHandler.players;
var board = oGameHandler.board;
if (array_length(board) > 0)
{
	var index = players[oGameHandler.player_turn].position;
	var offset_from = board[index].get_rotated_offset(board[index].width / 2, 3 * board[index].height / 2);
	var offset_to = board[index].get_rotated_offset(board[index].width / 2, 0);
	x = board[index].x + offset_from.x;
	y = board[index].y + offset_from.y;
	
	x_lookat = board[index].x + offset_to.x;
	y_lookat = board[index].y + offset_to.y;
}