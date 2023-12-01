extends State

@export var ability : State
@export var base : State

var weapon : Weapon
var can_attack : bool = true
var weapon_sprite : WeaponSprite

func physics_process(_delta : float) -> State:
	weapon = entity.get_current_weapon()
	
	weapon_sprite.look_at(entity.get_global_mouse_position())
	
	if sign(cos(weapon_sprite.rotation)) != 0:
		flip(sign(cos(weapon_sprite.rotation)) < 0)
	
	if GameManager.ability_bool:
		return ability
	
	if not entity.get_current_weapon():
		return base
	
	if not GameManager.block_input:
		if Input.is_action_pressed("player_attack") and can_attack:
			weapon.on_hold()
			can_attack = false
			get_tree().create_timer(weapon.rate).timeout.connect(on_timer_timeout)
			
		if not base.scroll_cooldown:
			if Input.is_action_just_pressed("weapon_up"):
				entity.change_slot(-1)
				entity.remove_child(weapon_sprite)
				add_sprite()
				
				base.scroll_cooldown = true
				get_tree().create_timer(base.scroll_rate).timeout.connect(base.scroll_timeout)
				
			elif Input.is_action_just_pressed("weapon_down"):
				entity.change_slot(1)
				entity.remove_child(weapon_sprite)
				add_sprite()
				
				base.scroll_cooldown = true
				get_tree().create_timer(base.scroll_rate).timeout.connect(base.scroll_timeout)
	
	return null

func add_sprite():
	weapon_sprite = entity.get_current_weapon().sprite
	entity.add_child(weapon_sprite)
	weapon_sprite.global_position += entity.weapon_pos.global_position - weapon_sprite.hold_point.global_position
	
	if sign(cos(weapon_sprite.rotation)) != 0:
		flip(sign(cos(weapon_sprite.rotation)) < 0)

func flip(flipped : bool):
	if weapon_sprite.flip_v != flipped:
		weapon_sprite.hold_point.position.y = -weapon_sprite.hold_point.position.y
		weapon_sprite.end_point.position.y = -weapon_sprite.end_point.position.y
	
	weapon_sprite.flip_v = flipped
	weapon_sprite.global_position += entity.weapon_pos.global_position - weapon_sprite.hold_point.global_position

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		GameManager.set_ability_bool(true)
	
	if event.is_action_pressed("player_attack"):
		weapon.on_press()
		
	if event.is_action_released("player_attack"):
		weapon.on_release()

	return null

func on_timer_timeout():
	can_attack = true

func start():
	base.scroll_cooldown = false
	
	if not weapon_sprite:
		add_sprite()
	
	GameManager.set_crosshair()

func end():
	if not entity.get_current_weapon():
		entity.remove_child(weapon_sprite)
