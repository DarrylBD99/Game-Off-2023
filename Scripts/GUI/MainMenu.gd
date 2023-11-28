extends Control

@export var play_button : Button
@export var credit_button : Button
@export var animation_player : AnimationPlayer
@export var quit_button : Button

func _ready():
	if play_button:
		play_button.pressed.connect(play_game)
	
	if credit_button:
		credit_button.pressed.connect(open_credits)
	
	if quit_button:
		quit_button.pressed.connect(quit_game)

func play_game():
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelTest.tscn")

func open_credits():
	animation_player.play("show_credits")

func quit_game():
	get_tree().quit()

