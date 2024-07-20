var game_state = get_game_state();
if (game_state_is("game"))
{
	draw_setup();
	draw_sprite(sBoard, 0, 0, 0);
	
	for (var i = 1; i < array_length(board); i++)
	{
		if (!is_undefined(board[i].owner))
		{
			var idx = get_player_index_from_id(board[i].owner);
			var top_left = board[i].get_rotated_offset(0, -32);
			var bottom_right = board[i].get_rotated_offset(board[i].width, 0);
			var col = players[idx].color;
			top_left.x += board[i].x;
			top_left.y += board[i].y;
			bottom_right.x += board[i].x;
			bottom_right.y += board[i].y;
			draw_rectangle_color(top_left.x, top_left.y, bottom_right.x, bottom_right.y, col, col, col, col, false);
		}
		if (board[i].upgradeable)
		{
			if (board[i].upgrade_state >= 2 && board[i].upgrade_state < 6)
			{
				for(var j = 1; j <= board[i].upgrade_state-1; j++)
				{
					var offset = board[i].get_rotated_offset(j * 25.6, 32)
					
					var matrix = matrix_build(board[i].x + offset.x, board[i].y + offset.y, -8, 0, 0, 0, 8, 8, 8);
					matrix_set(matrix_world, matrix);
					vertex_submit(global.models[? "House"], pr_trianglelist, sprite_get_texture(sHouseTexture, 0));
				}
			} else if (board[i].upgrade_state == 6)
			{
				var offset = board[i].get_rotated_offset(64, 32);
				var matrix = matrix_build(board[i].x + offset.x, board[i].y +  offset.y, -12, 0, 0, 0, 12, 12, 12);
				matrix_set(matrix_world, matrix);
				vertex_submit(global.models[? "Hotel"], pr_trianglelist, sprite_get_texture(sHotelTexture, 0));

			}
		}
	}
	
	for (var i = 0; i < array_length(players); i++) 
	{
		if (player_turn != i || positions_remaining == 0)
		{
			var pos = get_player_position(i, players[i].position);
			players[i].x = pos.x;
			players[i].y = pos.y;
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
		vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(asset_get_index($"sDiceTexture{consecutive_doubles}"), 0));
			
			
		matrix = matrix_build(board[index].x + offset2.x, board[index].y + offset2.y, -200, dice_rotation.x + 90, dice_rotation.y + 90, dice_rotation.z - 90, 32, 32, 32);
		matrix_set(matrix_world, matrix);
		vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(asset_get_index($"sDiceTexture{consecutive_doubles}"), 0));
			
		matrix_set(matrix_world, matrix_build_identity());

		var rotation_amount = 15;
		dice_rotation.x += rotation_amount;
		//dice_rotation.y += rotation_amount;
		dice_rotation.z += rotation_amount;
	}
}