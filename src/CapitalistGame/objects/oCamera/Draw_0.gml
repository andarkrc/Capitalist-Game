draw_clear_alpha(c_white, 1);
/*
x_lookat = x + cos(yaw_rotation)*cos(pitch_rotation);
y_lookat = y - sin(yaw_rotation)*cos(pitch_rotation);
z_lookat = z - sin(pitch_rotation);
*/

//Test dev on Linux

view_matrix = matrix_build_lookat(x, y, z, x_lookat, y_lookat, z_lookat, 0, 0, 1);
proj_matrix = matrix_build_projection_perspective_fov(100, window_get_width()/window_get_height(), 1, 32000);

camera_set_view_mat(camera, view_matrix);
camera_set_proj_mat(camera, proj_matrix);
camera_apply(camera);

var board = oGameHandler.board;
for (var i = 1; i < 41; i++)
{
	if (board[i].shape == "square") continue;
	//Love doing math on an inverted y axis :)
	var width = 128;//width & height are actually coords ;-;(most right x coord and down most y coord on normal xOy plane)
	var height = -256;//(0, 0) is top left of the board space
	var midx = width / 2;
	var midy = height / 2;
	var angle = board[i].rotation * pi / 180;
	var offx = midx * cos(angle) - midy * sin(angle);
	var offy = midx * sin(angle) + midy * cos(angle);
	var xx = board[i].x
	var yy = board[i].y;
	var matrix = matrix_build(xx + offx, yy - offy, -32, 0, 0, 0, 32, 32, 32);
	matrix_set(matrix_world, matrix);
	vertex_submit(global.models[? "Hotel"], pr_trianglelist, sprite_get_texture(sHotelTexture, 0));
}

matrix_set(matrix_world, matrix_build_identity());