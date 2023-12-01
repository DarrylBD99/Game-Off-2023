extends Area2D

func _on_area_entered(area):
	GameManager.level += 1
	Transition.change_scene("res://Scenes/Levels/level_" + str(GameManager.level) + ".tscn")
