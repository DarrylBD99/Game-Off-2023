extends STATE_ANIMATION

@export var base : State

func start():
	super.start()

func physics_process(delta : float) -> State:
	if isAnimationComplete and base.health_bar.modulate.a != 0:
		return base
	
	return super.physics_process(delta)
