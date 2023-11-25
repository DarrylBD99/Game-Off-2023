extends Ability

class_name Dash_ability

func _init():
	energy_cost = 10.0
	
	UI_desel = preload("res://Sprites/GUI/HUD/Ability/dash_desel.png")
	UI_sel = preload("res://Sprites/GUI/HUD/Ability/dash_sel.png")

func use_ability() -> bool:
	var player : Entity = GameManager.player
	
	if super.use_ability():
		player.dash_bool = true
		return true
	
	return false

func select():
	GameManager.set_ability_crosshair()
