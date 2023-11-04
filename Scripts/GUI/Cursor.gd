extends Sprite2D

var cursor_pos : Vector2

func _process(delta):
	cursor_pos = lerp(cursor_pos, get_global_mouse_position(), 1)
	global_position = cursor_pos
