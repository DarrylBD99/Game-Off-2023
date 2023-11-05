extends Label

@export var state_manager : StateManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state_manager:
		text = "State: " + state_manager.current_state.name
	else:
		queue_free()
