extends Node

class_name Health

@export var hp_max : float = 10.0
@export var object : Node

@onready var hp : float = hp_max

func damage(attack : Attack):
	hp -= attack.atk

func _process(_delta):
	if hp <= 0:
		object.queue_free()
