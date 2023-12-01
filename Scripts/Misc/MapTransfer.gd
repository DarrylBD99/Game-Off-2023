extends Area2D

func _ready():
	area_entered.connect(next_level)

func next_level():
	GameManager.level += 1
	Transition.change_scene("res://Scenes/Levels/level_" + str(GameManager.level) + ".tscn")
	
