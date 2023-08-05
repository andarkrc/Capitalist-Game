var ratio_x = 1080/room_width;
var ratio_y = 720/room_height;

drawSetup(c_white, 0.8);
draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, false);
drawSetup(c_ltgray);
draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, true);
if(mouse_hover)
{
	drawSetup(c_blue);
	draw_rectangle(x*ratio_x, y*ratio_y, (x+width)*ratio_x, (y+height)*ratio_y, true);
}
drawSetup(c_black, 1, font);
draw_text_transformed((x+width/2)*ratio_x, (y+height/2)*ratio_y, text, ratio_x, ratio_y, 0);