var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

draw_setup(c_white, 0.8);
draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, false);
draw_setup(c_ltgray);
draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, true);
if(mouse_hover)
{
	draw_setup(c_blue);
	draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, true);
}
draw_setup(c_black, 1, font);
var display_text = text;
if(line_flash && can_write) display_text += "|";
draw_text_transformed((x+width/2)*ratio_x, (y+height/2)*ratio_y, display_text, ratio_x, ratio_y, 0);
