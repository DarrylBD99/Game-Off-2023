extends State

@export var attack : State
@export var base : State

var scroll_cooldown : bool
var scroll_rate : float = 0.2

func physics_process(_delta : float) -> State:
	if not scroll_cooldown:
		if Input.is_action_just_pressed("weapon_up"):
			entity.change_ability(-1)
			entity.get_current_ability().select()
			
			scroll_cooldown = true
			get_tree().create_timer(scroll_rate).timeout.connect(scroll_timeout)
			
		elif Input.is_action_just_pressed("weapon_down"):
			entity.change_ability(1)
			entity.get_current_ability().select()
			
			scroll_cooldown = true
			get_tree().create_timer(scroll_rate).timeout.connect(scroll_timeout)
	
	return null

func scroll_timeout():
	scroll_cooldown = false

func input(event : InputEvent) -> State:
	if event.is_action_pressed("player_ability"):
		return disable_ability()
	
	if event.is_action_pressed("player_attack"):
		var ability : Ability = entity.get_current_ability()
		if ability.use_ability():
			return disable_ability()
	
	return null

func start():
	scroll_cooldown = false
	entity.get_current_ability().select()

func disable_ability() -> State:
	GameManager.set_ability_bool(false)
	return base
	
