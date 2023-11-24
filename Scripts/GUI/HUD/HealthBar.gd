extends ProgressBar

@export var lerp_weight : float = 60
var current_hp : float
var health_max : float
var old_hp : float
var flash_timer : Timer

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

func flash(a : float):
	if material:
		material.set_shader_parameter("flash_alpha", a)

func _process(_delta):
	value = roundi(current_hp / health_max * max_value)
	
	if GameManager.player:
		old_hp = GameManager.player.health.hp
		
		if current_hp != old_hp:
			current_hp = old_hp
			
			flash(0.7)
			flash_timer.start()

func _on_flash_finish():
	flash(0)
