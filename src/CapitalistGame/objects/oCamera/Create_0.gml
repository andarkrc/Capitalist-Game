x = 0;
y = 0;
z = -250;

x_lookat = 1664;
y_lookat = 832;
z_lookat = 0;

pos_angle = 315;

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
old_camera = camera_get_active();
camera = camera_create();
camera_set_default(camera);
view_matrix = undefined;
proj_matrix = undefined;

