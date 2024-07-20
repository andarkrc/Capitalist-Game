var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

draw_setup(color, 1);
draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, false);

if (!active)
{
	draw_setup(overlay_color, 0.7);
	draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, false);
}
if(mouse_hover)
{
	draw_setup(c_blue);
	draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, true);
}
if (added_to_trade)
{
	draw_setup(secondary_color, 1, font);
	draw_text_transformed((x+width/2)*ratio_x, (y+height/2)*ratio_y, text, ratio_x, ratio_y, 0);
}