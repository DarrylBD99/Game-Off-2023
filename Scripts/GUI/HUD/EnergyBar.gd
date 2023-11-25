extends TextureProgressBar

var current_energy : float
var energy_max : float
var old_energy : float

var flash_diff : float
var flash_rate : float

func _ready():
	if GameManager.player:
		current_energy = GameManager.player.energy.energy
		energy_max = GameManager.player.energy.energy_max
		
		old_energy = current_energy

func _process(delta):
	value = roundi(current_energy / energy_max * max_value)
	
	if GameManager.ability_bool or GameManager.changing_size:
		flash_rate = 1
		
		if GameManager.changing_size:
			flash_rate = 2
		
		var new_shader_a : float = material.get_shader_parameter("flash_alpha") + (flash_rate * flash_diff * delta * 2)
		
		if new_shader_a > 0.7:
			new_shader_a = 0.7
		elif new_shader_a < 0:
			new_shader_a = 0
		
		material.set_shader_parameter("flash_alpha", new_shader_a)
		
		if new_shader_a == flash_diff or new_shader_a == 0:
			if flash_diff == 0.7:
				flash_diff = -0.7
			else:
				flash_diff = 0.7
	else:
		material.set_shader_parameter("flash_alpha", 0)
		flash_diff = 0.7
	
	if GameManager.player:
		current_energy = lerpf(current_energy, GameManager.player.energy.energy, 10 * delta)

