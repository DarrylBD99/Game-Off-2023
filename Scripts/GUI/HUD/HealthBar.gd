extends TextureProgressBar

@export var lerp_weight : float = 50
var current_hp : float
var health_max : float
var old_hp : float
var flash_timer : Timer
var value_temp : float

func _ready():
	flash_timer = Timer.new()
	flash_timer.wait_time = 0.1
	flash_timer.one_shot = true
	add_child(flash_timer)
	flash_timer.timeout.connect(_on_flash_finish)
	
	if GameManager.player:
		current_hp = GameManager.player.health.hp
		health_max = GameManager.player.health.hp_max
		
		old_hp = current_hp
		
		value = roundi(current_hp / health_max * max_value)

func _process(delta):
	if GameManager.player:
		old_hp = GameManager.player.health.hp
		
		if current_hp != old_hp:
			current_hp = old_hp
			material.set_shader_parameter("flash_alpha", 0.7)
			value_temp = value
			flash_timer.start()
	
	if not flash_timer.is_stopped():
		value = lerpf(value, roundi(current_hp / health_max * max_value), lerp_weight * delta)
	else:
		value =  roundi(current_hp / health_max * max_value)

func _on_flash_finish():
	material.set_shader_parameter("flash_alpha", 0)
	value = roundi(current_hp / health_max * max_value)
