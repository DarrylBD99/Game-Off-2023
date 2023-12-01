extends ProgressBar

var hp : float
var hp_max : float
var old_value : float
var flash_timer : Timer

func _ready():
	flash_timer = Timer.new()
	flash_timer.wait_time = 0.1
	flash_timer.one_shot = true
	add_child(flash_timer)
	flash_timer.timeout.connect(_on_flash_finish)
	
	if GameManager.player:
		hp = GameManager.player.health.hp
		hp_max = GameManager.player.health.hp_max
		
		value = hp / hp_max * max_value
		old_value = value

func flash(a : float):
	if material:
		material.set_shader_parameter("flash_alpha", a)

func _process(_delta):
	old_value = value
	
	if GameManager.player:
		hp = GameManager.player.health.hp
		hp_max = GameManager.player.health.hp_max
		value = hp / hp_max * max_value
		
		if value < old_value:
			flash(0.7)
			flash_timer.start()

func _on_flash_finish():
	flash(0)
