extends State

@export var ability : State
@export var base : State

var weapon : Weapon
var can_attack : bool = true
var weapon_rate : Timer

func physics_process(_delta : float) -> State:
	weapon = entity.get_current_weapon()
	
	weapon_rate.wait_time = weapon.rate
	
	if GameManager.ability_bool:
		return ability
	
	if can_attack:
		weapon_rate.stop()
	elif weapon_rate.is_stopped():
		weapon_rate.start()
	
	if not entity.get_current_weapon():
		return base
	
	if Input.is_action_pressed("player_attack") and can_attack:
		weapon.on_hold()
		can_attack = false
	
	return null

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		GameManager.set_ability_bool(true)
	
	if event.is_action_pressed("player_attack"):
		weapon.on_press()
		
	if event.is_action_released("player_attack"):
		can_attack = true
		weapon.on_release()

	return null

func on_timer_timeout():
	can_attack = true

func start():
	GameManager.set_crosshair()

func state_ready():
	weapon_rate = Timer.new()
	weapon_rate.one_shot = true
	weapon_rate.timeout.connect(on_timer_timeout)
	entity.add_child(weapon_rate)
