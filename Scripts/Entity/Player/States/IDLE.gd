extends State

@export var run : State
@export var dash : State

func physics_process(_delta : float) -> State:
	move_pos = Vector2.ZERO
	
	if not GameManager.block_input:
		move_pos = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	if move_pos != Vector2.ZERO:
		return run
	
	if entity.dash_bool:
		return dash
	
	return null
