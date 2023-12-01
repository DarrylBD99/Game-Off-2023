extends State

@export var stage_1 : State

func physics_process(_delta) -> State:
	if entity.target:
		return stage_1
	
	return null
