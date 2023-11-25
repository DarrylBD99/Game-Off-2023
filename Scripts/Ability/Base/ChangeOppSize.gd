extends Ability

class_name ChangeOppSize

var size_index : int = 0

func _init():
	UI_desel = preload("res://Sprites/GUI/HUD/Ability/minimize_desel.png")
	UI_sel = preload("res://Sprites/GUI/HUD/Ability/minimize_sel.png")
	energy_cost = 10.0

func use_ability() -> bool:
	var player : Entity = GameManager.player
	
	if super.use_ability():
		if player.AimRayCast.is_colliding():
			var hitbox_opp : Hitbox = player.AimRayCast.get_collider()
			if hitbox_opp is Hitbox:
				hitbox_opp.change_size(size_index)
				player.energy.deplete_energy(energy_cost)
				return true
	
	return false

func select():
	GameManager.set_ability_crosshair()
