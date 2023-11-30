extends State

@export var attack : State
@export var base : State

func physics_process(_delta : float) -> State:
	if not base.scroll_cooldown:
		if Input.is_action_just_pressed("weapon_up"):
			entity.change_ability(-1)
			entity.get_current_ability().select()
			
			base.scroll_cooldown = true
			get_tree().create_timer(base.scroll_rate).timeout.connect(base.scroll_timeout)
			
		elif Input.is_action_just_pressed("weapon_down"):
			entity.change_ability(1)
			entity.get_current_ability().select()
			
			base.scroll_cooldown = true
			get_tree().create_timer(base.scroll_rate).timeout.connect(base.scroll_timeout)
	
	return null

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		return disable_ability()
	
	if event.is_action_pressed("player_attack"):
		var ability : Ability = entity.get_current_ability()
		if ability.use_ability():
			return disable_ability()
	
	return null

func start():
	base.scroll_cooldown = false
	entity.get_current_ability().select()

func disable_ability() -> State:
	GameManager.set_ability_bool(false)
	return base
	
