extends State

@export var attack : State
@export var base : State
@export var attack_range : float
@export var visuals : Sprite2D

var old_hp : float

func start():
	visuals.hide()
	old_hp = entity.health.hp
	
func end():
	visuals.show()
	
func physics_process(_delta : float) -> State:	
	# if we are close do an attack
	if (entity.target && entity.target_distance <= attack_range):
		return attack;
	
	if entity.health.hp != old_hp:
		return base
		
	
	return null
