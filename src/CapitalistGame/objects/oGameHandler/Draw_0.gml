var game_state = get_game_state();
if (game_state_is("game"))
{
	draw_sprite(sBoard, 0, 0, 0);

	if (game_state == "game_rolling_dice")
	{
		var index = players[player_turn].position;
		var offset = board[index].get_rotated_offset(board[index].width / 2, board[index].height / 2);
		with(oCamera)
		{
			var matrix = matrix_build(board[index].x + offset.x, board[index].y + offset.y, -200, other.dice_rotation.x, other.dice_rotation.y, other.dice_rotation.z, 48, 48, 48);
			matrix_set(matrix_world, matrix);
			vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
			matrix_set(matrix_world, matrix_build_identity());
		}
		dice_rotation.x += random(1) * choose(1, -1);
		dice_rotation.y += random(1) * choose(1, -1);
		dice_rotation.z += random(1) * choose(1, -1);
	}	
}