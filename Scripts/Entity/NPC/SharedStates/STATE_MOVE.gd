extends State
class_name STATE_MOVE

@export var next_state : State

func is_ready() -> bool:
	if not entity.target:
		return false
	
	return true

func end():
	entity.velocity = Vector2(0, 0)
	
func physics_process(_delta : float) -> State:
	if not entity.target:
		return next_state
	
	entity.velocity = entity.navigation_direction * entity.speed
	entity.move_and_slide()

	return null
