extends State
class_name IDLE_State

@export var next_state : State

func physics_process(_delta : float) -> State:
	return next_state
