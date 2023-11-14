extends Node

class_name Health

@export var hp_max : float = 10.0
@export var shake_screen : bool = false

@onready var hp : float = hp_max

func damage(attack : Attack):
	hp -= attack.atk
	
	get_parent().flash()
	
	if shake_screen:
		GameManager.camera.shake(2.0)
	

func _process(_delta):
	if hp <= 0:
		get_parent().queue_free()
