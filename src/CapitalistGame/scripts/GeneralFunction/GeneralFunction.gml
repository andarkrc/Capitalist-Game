///@function drawSetup
///@param {Constant.Color} color_
///@param {Real} alpha_
///@param {Asset.GMFont} font_
///@param {Constant.HAlign} halign_
///@param {Constant.VAlign} valign_
function drawSetup(color_ = c_black, alpha_ = 1, font_ = fnMedium, halign_ = fa_center, valign_ = fa_middle){
	draw_set_color(color_);
	draw_set_alpha(alpha_);
	draw_set_font(font_);
	draw_set_halign(halign_);
	draw_set_valign(valign_);
}