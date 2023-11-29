extends State

@export var cooldown : float = 5.0
@export var idle : State
@export var attack : State

var cooldown_bool : bool

func physics_process(delta : float) -> State:
	if not cooldown_bool:
		if attack.is_ready():
			return attack
		
		return idle
	
	return null

func start():
	cooldown_bool = true
	get_tree().create_timer(cooldown).timeout.connect(end_of_cooldown)

func end_of_cooldown():
	cooldown_bool = false
