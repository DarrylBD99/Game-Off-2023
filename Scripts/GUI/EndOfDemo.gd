extends Control

func transfer_to_menu():
	GameManager.game_beaten = true
	Transition.change_scene("res://Scenes/GUI/MainMenu.tscn")
	
