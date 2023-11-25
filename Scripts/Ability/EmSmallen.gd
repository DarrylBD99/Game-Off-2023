extends ChangeOppSize

class_name EmSmallen

func _init():
	super._init()
	
	UI_desel = preload("res://Sprites/GUI/HUD/Ability/enemy_small_desel.png")
	UI_sel = preload("res://Sprites/GUI/HUD/Ability/enemy_small_sel.png")
	
	size_index = 0
