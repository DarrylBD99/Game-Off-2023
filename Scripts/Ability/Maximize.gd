extends ChangePlayerSize

class_name Maximize

func _init():
	super._init()
	
	UI_desel = preload("res://Sprites/GUI/HUD/Ability/maximize_desel.png")
	UI_sel = preload("res://Sprites/GUI/HUD/Ability/maximize_sel.png")
	
	size_index = 2
