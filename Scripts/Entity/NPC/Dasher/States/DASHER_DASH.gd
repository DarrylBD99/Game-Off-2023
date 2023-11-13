extends STATE_ANIMATION

@export var DashMotion : CustomMotion
@export var target_range : float

func is_ready() -> bool:
	if not GameManager.target:
		return false
	
	return entity.target_distance < target_range
	
func start():
	super.start()
	
	if (GameManager.target):
		DashMotion.play(entity, entity.target_direction)

func physics_process(_delta : float) -> State:
	DashMotion.manual_process(_delta)
	
	if (!DashMotion.isPlaying):
		return next_state;
	
	return null
