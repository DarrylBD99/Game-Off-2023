extends State

@export var idle : State
@export var attack : State

func physics_process(delta) -> State:
	if attack.is_ready():
		return attack
	
	return idle
