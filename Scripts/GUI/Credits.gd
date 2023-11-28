extends Panel

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_parent().animation_player.play("hide_credits")
