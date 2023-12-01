extends ProgressBar

@export var boss : Entity

var hp : float
var hp_max : float
var old_value : float

func _ready():
	if boss:
		hp = boss.health.hp
		hp_max = boss.health.hp_max
		
		value = hp / hp_max * max_value
		old_value = value

func flash(a : float):
	if material:
		material.set_shader_parameter("flash_alpha", a)

func _process(_delta):
	old_value = value
	
	if boss:
		hp = boss.health.hp
		hp_max = boss.health.hp_max
		value = hp / hp_max * max_value
