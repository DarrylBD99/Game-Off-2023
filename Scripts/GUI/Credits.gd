extends Panel

func _input(event):
	if event.is_action_pressed("ui_cancel") and get_parent().credit_roll:
		get_parent().animation_player.play_backwards("credits")
		await get_parent().animation_player.animation_finished
		get_parent().credit_roll = false
