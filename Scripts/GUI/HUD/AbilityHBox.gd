extends HBoxContainer

func _process(delta):
	if GameManager.player:
		var ability : Ability = GameManager.player.get_current_ability()
		
		if ability:
			show()
		else:
			hide()
