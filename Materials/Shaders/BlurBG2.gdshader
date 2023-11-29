shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 5.0) = 0;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	COLOR = textureLod(screen_texture, UV, blur_amount);
}