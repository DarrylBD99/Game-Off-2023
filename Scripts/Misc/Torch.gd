extends Node2D

class_name Torch

var power_max : float = 100
var power : float = power_max

var using : bool = false

func _process(_delta):
	if using:
		power -= 1
		if power <= 0:
			using = false
	else:
		power += 2
		
		if power > power_max:
			power = power_max
		
	
