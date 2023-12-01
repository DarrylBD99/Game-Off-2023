extends State

@export var cooldown_time : float
@export var next_state : State

var cooldown : bool

func physics_process(delta : float) -> State:
	if not cooldown:
		return next_state
	
	return null

func start():
	cooldown = true
	entity.cooldown()
	get_tree().create_timer(cooldown_time).timeout.connect(get_next_state)

func get_next_state():
	entity.cooldown_end()
	await get_tree().create_timer(4).timeout
	cooldown = false
