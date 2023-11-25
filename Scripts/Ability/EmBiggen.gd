extends ChangeOppSize

class_name EmBiggen

func _init():
	super._init()
	
	UI_desel = preload("res://Sprites/GUI/HUD/Ability/minimize_desel.png")
	UI_sel = preload("res://Sprites/GUI/HUD/Ability/minimize_sel.png")
	
	size_index = 2
