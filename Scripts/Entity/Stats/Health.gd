extends Node

class_name Health

@export var hp_max : float = 10.0
@export var shake_screen : bool = false
@export var passive_rate : float = 0

@onready var hp : float = hp_max

func damage(attack : Attack):
	hp -= attack.atk
	
	get_parent().flash()
	
	if shake_screen:
		GameManager.camera.shake(2.0)
	

func _process(_delta):
	hp += passive_rate
	
	if hp > hp_max:
		hp = hp_max
	
	if hp <= 0:
		get_parent().add_sibling(preload("res://Scenes/Particles/AcidBurst.tscn").instantiate())
		get_parent().queue_free()
