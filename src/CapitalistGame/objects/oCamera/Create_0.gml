z = -200;
x = 0;
y = 0;

x_lookat = room_width/2;
y_lookat = room_height/2;
z_lookat = 0;

dice_rotationx = 0;
dice_rotationy = 0;
dice_rotationz = 0;

move_speed = 16;
yaw_rotation = pi/2; // Side to Side
pitch_rotation = -pi/4; // Up to Down
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(10);
camera = camera_get_active();
view_matrix = undefined;
proj_matrix = undefined;





///@function get_player_xy_from_position
///@param {Real} position_
///@param {Real} player_
get_player_xy_from_position = function(position_, player_){
	var pos = {
		x : 0,
		y : 0
	}
	
	var offx = 0;
	var offy = 0;
	
	if(position_ == 1)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + 64;
			offy = 64 + player_*64;
		}
		else
		{
			offx = 16  + 64 + 64;
			offy = 64 + (player_-3)*64;
		}
	}
	
	if(position_ >= 2 && position_ <= 10)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16;
			offy = 64 + player_*64;
		}
		else
		{
			offx = 16 + 64;
			offy = 64 + (player_-3)*64;
		}
	}
	
	if(position_ == 11)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + 64;
			offy = 64 + player_*64;
		}
		else
		{
			offx = 16  + 64 + 64;
			offy = 64 + (player_-3)*64;
		}
	}
	
	if(position_ >= 12 && position_ <= 20)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + (2-player_)*64;
			offy = 16;
		}
		else
		{
			offx = 16 + (5-player_)*64;
			offy = 16 + 64;
		}
	}
	
	if(position_ == 21)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + 64 + 64;
			offy = 16 + (2-player_)*64;
		}
		else
		{
			offx = 16 + 64;
			offy = 16 + (5-player_)*64;
		}
	}
	
	if(position_ >= 22 && position_ <= 30)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + 64;
			offy = 16 + (2-player_)*64;
		}
		else
		{
			offx = 16;
			offy = 16 + (5-player_)*64;
		}
	}
	
	if(position_ == 31)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + 64 + (player_)*64;
			offy = 16 + 64 + 64;
		}
		else
		{
			offx = 16 + 64 + (player_-3)*64;
			offy = 16 + 64;
		}
	}
	
	if(position_ >= 32 && position_ <= 40)
	{
		if(player_ >= 0 && player_ <= 2)
		{
			offx = 16 + 64 + (player_)*64;
			offy = 16 + 64;
		}
		else
		{
			offx = 16 + 64 + (player_-3)*64;
			offy = 16;
		}
	}
	pos.x = offx;
	pos.y = offy;
	return pos;
}