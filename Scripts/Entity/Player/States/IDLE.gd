extends State

@export var run : State

func physics_process(_delta : float) -> State:
	move_pos = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	if move_pos != Vector2.ZERO:
		return run
	
	return null
