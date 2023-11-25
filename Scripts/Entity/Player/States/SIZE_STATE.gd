extends SizeState

@export var medium : State
@export var deplete_rate : float = 5

func physics_process(delta : float) -> State:
	super.physics_process(delta)
	
	entity.energy.deplete_energy(delta * deplete_rate)
	
	if entity.energy.energy <= 0:
		return medium
	
	return null

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		return medium
	
	return null

func start():
	GameManager.changing_size = true
	super.start()

func end():
	GameManager.changing_size = false
	super.end()
