extends Node

class_name Health

@export var hp_max : float = 10.0

@onready var hp : float = hp_max

func damage(attack : Attack):
	hp -= attack.atk

func _process(_delta):
	if hp <= 0:
		get_parent().queue_free()
