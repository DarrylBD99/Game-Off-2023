extends Node2D
class_name room_spawnpoint

@export var direction : int

func _process(delta):
	if direction == 0:
		pass
		#spawn at top
	elif direction == 1:
		pass
		#spawn at bottom
	elif direction == 2:
		pass
		#spawn at left
	elif direction == 3:
		pass
		#spawn at right
