var game_state = get_game_state();
if (game_state_is("game"))
{
	draw_sprite(sBoard, 0, 0, 0);

	for (var i = 0; i < array_length(players); i++) 
	{
		if (players[i].target == players[i].position)
		{
			var pos = players[i].position;
			var hoff = floor(i / 3) - 0.5 ;
			var voff = (i % 3 ) - 1;
			var offset = board[pos].get_rotated_offset(board[pos].width / 2 + hoff * 64, 160 + voff * 64);
			players[i].x = board[pos].x+ offset.x;
			players[i].y = board[pos].y + offset.y;
			
		}
		var matrix = matrix_build(players[i].x, players[i].y, -16, 0, 0, 0, 16, 16, 16);
		matrix_set(matrix_world, matrix);
		var texture = asset_get_index($"sPieceTexture{players[i].piece}");
		vertex_submit(global.models[? "Rat"], pr_trianglelist, sprite_get_texture(texture, 0));
		matrix_set(matrix_world, matrix_build_identity());
		
		if (players[i].target != players[i].position)
		{
		}
	}

	if (game_state == "game_rolling_dice")
	{
		var index = players[player_turn].position;
		var offset1 = board[index].get_rotated_offset(board[index].width / 2 - 64, board[index].height / 2);
		var offset2 = board[index].get_rotated_offset(board[index].width / 2 + 64, board[index].height / 2);
		var matrix = matrix_build(board[index].x + offset1.x, board[index].y + offset1.y, -200, dice_rotation.x, dice_rotation.y, dice_rotation.z, 32, 32, 32);
		matrix_set(matrix_world, matrix);
		vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
			
			
		matrix = matrix_build(board[index].x + offset2.x, board[index].y + offset2.y, -200, dice_rotation.x + 90, dice_rotation.y + 90, dice_rotation.z - 90, 32, 32, 32);
		matrix_set(matrix_world, matrix);
		vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
			
		matrix_set(matrix_world, matrix_build_identity());

		var rotation_amount = 15;
		dice_rotation.x += rotation_amount;
		//dice_rotation.y += rotation_amount;
		dice_rotation.z += rotation_amount;
	}
}