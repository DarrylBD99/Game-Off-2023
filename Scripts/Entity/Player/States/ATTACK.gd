extends State

@export var ability : State
@export var base : State

func physics_process(_delta : float) -> State:
	if GameManager.ability_bool:
		return ability
	
	if not entity.get_current_weapon():
		return base
	
	if Input.is_action_pressed("player_attack") and entity.can_fire:
		entity.shoot_bullet(entity.bullet_scene, entity.global_position, entity.get_global_mouse_position(), 1)
		entity.attack_1_sfx.play()
	
	return null

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		GameManager.set_ability_bool(true)

	return null
