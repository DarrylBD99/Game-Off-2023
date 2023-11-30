extends TextureRect

func _process(_delta):
	if GameManager.player:
		var weapon : Weapon = GameManager.player.get_current_weapon()
		
		if weapon:
			if GameManager.ability_bool: texture = weapon.UI_desel
			else: texture = weapon.UI_sel
