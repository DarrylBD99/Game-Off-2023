extends TextureRect

func _process(_delta):
	if GameManager.player:
		var ability : Ability = GameManager.player.get_current_ability()
		
		if ability:
			if GameManager.ability_bool: texture = ability.UI_sel
			else: texture = ability.UI_desel
