///@function draw_setup
///@param {Constant.Color} color_
///@param {Real} alpha_
///@param {Asset.GMFont} font_
///@param {Constant.HAlign} halign_
///@param {Constant.VAlign} valign_
function draw_setup(color_ = c_black, alpha_ = 1, font_ = fnLeelawadee16, halign_ = fa_center, valign_ = fa_middle)
{
	draw_set_color(color_);
	draw_set_alpha(alpha_);
	draw_set_font(font_);
	draw_set_halign(halign_);
	draw_set_valign(valign_);
}

///@function draw_square
///@param {Real} x_
///@param {Real} y_
///@param {Real} side_length_
///@param {Bool} outline_
function draw_square(x_, y_, side_length_, outline_ = false)
{
	draw_rectangle(x_ - side_length_ / 2, y_ - side_length_ / 2, x_ + side_length_ / 2, y_ + side_length_ / 2, outline_);
}

///@function buffer_duplicate
///@param {Id.Buffer}
function buffer_duplicate(buffer_)
{
	var buff = buffer_create(1, buffer_grow, 1);
	buffer_seek(buff, buffer_seek_start, 0);
	buffer_seek(buffer_, buffer_seek_end, 0);
	buffer_copy(buffer_, 0, buffer_tell(buffer_), buff, 0);
	return buff;
}