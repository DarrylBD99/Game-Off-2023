extends State
class_name IDLE_State

@export var next_state : State
@export var animation_player : AnimationPlayer

func physics_process(_delta : float) -> State:
	return next_state

func start():
	if not animation_player.is_playing():
		animation_player.play("IDLE")
