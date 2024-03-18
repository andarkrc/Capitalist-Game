var game_state = get_game_state();
if (game_state_is("game"))
{
	draw_sprite(sBoard, 0, 0, 0);

	if (game_state == "game_rolling_dice")
	{
		var index = players[player_turn].position;
		var offset1 = board[index].get_rotated_offset(board[index].width / 2 - 64, board[index].height / 2);
		var offset2 = board[index].get_rotated_offset(board[index].width / 2 + 64, board[index].height / 2);
		with(oCamera)
		{
			var matrix = matrix_build(other.board[index].x + offset1.x, other.board[index].y + offset1.y, -200, other.dice_rotation.x, other.dice_rotation.y, other.dice_rotation.z, 32, 32, 32);
			matrix_set(matrix_world, matrix);
			vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
			
			
			matrix = matrix_build(other.board[index].x + offset2.x, other.board[index].y + offset2.y, -200, other.dice_rotation.x + 90, other.dice_rotation.y + 90, other.dice_rotation.z - 90, 32, 32, 32);
			matrix_set(matrix_world, matrix);
			vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
			
			matrix_set(matrix_world, matrix_build_identity());
		}
		var rotation_amount = 15;
		dice_rotation.x += rotation_amount;
		//dice_rotation.y += rotation_amount;
		dice_rotation.z += rotation_amount;
	}	
}