extends Node

class_name Energy

@export var energy_max : float = 40.0
@export var passive_rate : float = 1

@onready var energy : float = energy_max

func deplete_energy(amount : float):
	energy -= amount

func _process(_delta):
	energy += passive_rate
	
	if energy > energy_max:
		energy = energy_max
