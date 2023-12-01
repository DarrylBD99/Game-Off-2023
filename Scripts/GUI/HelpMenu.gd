extends Panel

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		hide()
