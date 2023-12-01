extends State

class_name StageState

@export var next_stage : State
@export var attack_amount : int

var attacked : int

func physics_process(delta : float) -> State:
	attacked += 1
	if attacked == attack_amount:
		return next_stage
	
	return null

func start():
	attacked = 0
