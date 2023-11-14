extends Camera2D

@export var shake_fade : float = 5
var shake_strength : float = 0

func _ready():
	GameManager.camera = self

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		
		offset = random_offset()

func random_offset() -> Vector2:
	GameManager.set_random_seed()
	var offset_x : float = GameManager.random.randf_range(-shake_strength, shake_strength)
	var offset_y : float = GameManager.random.randf_range(-shake_strength, shake_strength)
	
	return Vector2(offset_x, offset_y)
	
func shake(strength : float):
	shake_strength += strength
	if shake_strength > 5:
		shake_strength = 5
