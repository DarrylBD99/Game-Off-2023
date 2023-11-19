extends State

@export var attack : State
@export var invis : State
@export var health_bar : TextureProgressBar

func physics_process(_delta : float) -> State:
	if health_bar.modulate.a == 0:
		return invis
	
	if (entity.target && entity.target_distance <= invis.attack_range):
		return attack
	
	return null
