draw_clear_alpha(c_white, 1);
/*
x_lookat = x + cos(yaw_rotation)*cos(pitch_rotation);
y_lookat = y - sin(yaw_rotation)*cos(pitch_rotation);
z_lookat = z - sin(pitch_rotation);
*/
view_matrix = matrix_build_lookat(x, y, z, x_lookat, y_lookat, z_lookat, 0, 0, 1);
proj_matrix = matrix_build_projection_perspective_fov(100, window_get_width()/window_get_height(), 1, 32000);

camera_set_view_mat(camera, view_matrix);
camera_set_proj_mat(camera, proj_matrix);
camera_apply(camera);

var players = oGameHandler.players;
var board = oGameHandler.board;

var offx = 0;
var offy = 0;
var matrix;


for(var i = 0; i < array_length(players); i++)
{
	var pos = get_player_xy_from_position(players[i].position, i);
	offx = pos.x;
	offy = pos.y;
	
	if(players[oGameHandler.player_turn-1].id != players[i].id || oGameHandler.spaces_left == 0)
	{
		matrix = matrix_build(board[players[i].position].xx1 + 12 + offx, board[players[i].position].yy1 + 24 + offy, -16, 0, 0, 0, 16, 16, 16);
	}
	else
	{
		matrix = matrix_build(oGameHandler.player_current_x, oGameHandler.player_current_y, -16, 0, 0, 0, 16, 16, 16);
	}
	matrix_set(matrix_world, matrix);
	vertex_submit(global.models[? players[i].piece], pr_trianglelist, sprite_get_texture(asset_get_index($"sPieceTexture{players[i].piece}"), 0));
}

if(oGameHandler.dice_rolling)
{
	var pos = players[oGameHandler.player_turn-1].position
	offx = board[pos].xx1;
	offy = board[pos].yy1;
	if(pos == 1 || pos == 11 || pos == 21 || pos == 31)
	{
		offx += 128;
		offy += 128;
	}
	if(pos >= 2 && pos <= 10)
	{
		offx += 64;
		offy += 128;
	}
	if(pos >= 12 && pos <= 20)
	{
		offx += 128;
		offy += 64;
	}
	if(pos >= 22 && pos <= 30)
	{
		offx += 64;
		offy += 128;
	}
	if(pos >= 32 && pos <= 40)
	{
		offx += 128;
		offy += 64;
	}
	matrix = matrix_build(offx, offy, -100, dice_rotationx, dice_rotationy, dice_rotationz, 16, 16, 16);
	matrix_set(matrix_world, matrix);
	vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
	matrix = matrix_build(offx, offy, -150, dice_rotationx+90, dice_rotationy+90, dice_rotationz+90, 16, 16, 16);
	matrix_set(matrix_world, matrix);
	vertex_submit(global.models[? "Dice"], pr_trianglelist, sprite_get_texture(sDiceTexture, 0));
	dice_rotationx += 12;
	dice_rotationy += 12;
	//dice_rotationz += 1;
	if(dice_rotationx > 360) dice_rotationx -= 360;
	if(dice_rotationy > 360) dice_rotationy -= 360;
	if(dice_rotationz > 360) dice_rotationz -= 360;
}

matrix_set(matrix_world, matrix_build_identity());