extends State

@export var next_state : State
@export var wait_time : float

var wait_timer = 0;

func start():
	wait_timer = 0
	
func physics_process(_delta : float) -> State:
	wait_timer += _delta
	
	if (wait_timer >= wait_time):
		return next_state
		
	return null
