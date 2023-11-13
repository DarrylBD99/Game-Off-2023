extends State

@export var next_state : State
@export var attack_range : float
@export var visuals : Sprite2D

func start():
	visuals.hide()
	
func end():
	visuals.show()
	
func physics_process(_delta : float) -> State:
	if (!GameManager.target):
		return next_state;
	
	# if we are close do an attack
	if (entity.target_distance <= attack_range):
		return next_state;
	
	return null
