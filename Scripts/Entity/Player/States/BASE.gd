extends State

@export var ability : State
@export var attack : State

var scroll_cooldown : bool
var scroll_rate : float = 0.2

func physics_process(_delta):
	if GameManager.ability_bool:
		return ability
	elif entity.get_current_weapon():
		return attack
	
	return null

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		GameManager.set_ability_bool(true)

	return null

func start():
	scroll_cooldown = false
	GameManager.set_x_crosshair()


func scroll_timeout():
	scroll_cooldown = false
