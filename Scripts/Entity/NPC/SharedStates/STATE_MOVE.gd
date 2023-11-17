extends State
class_name STATE_MOVE

@export var next_state : State
@export var target_range : float

func is_ready() -> bool:
	if not entity.target:
		return false
	
	return entity.target_distance > target_range

func end():
	entity.velocity = Vector2(0, 0)
	
func physics_process(_delta : float) -> State:
	if not entity.target:
		return null
	
	if (entity.target_distance <= target_range):
		return next_state;
	
	entity.velocity = entity.navigation_direction * entity.speed
	entity.move_and_slide()

	return null
