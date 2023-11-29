extends Control

@export var play_button : Button
@export var credit_button : Button
@export var animation_player : AnimationPlayer
@export var quit_button : Button

var credit_roll : bool = false
var hovering : bool = false

var buttons : Array[Button]

func _ready():
	GameManager.set_default()
	
	if play_button:
		buttons.append(play_button)
		play_button.pressed.connect(play_game)
	
	if credit_button:
		buttons.append(credit_button)
		credit_button.pressed.connect(open_credits)
	
	if quit_button:
		buttons.append(quit_button)
		quit_button.pressed.connect(quit_game)

func _process(_delta):
	for button in buttons:
		if button.is_hovered():
			if not hovering:
				$Hover.play()
				hovering = true
				return
			else:
				return
	
	hovering = false

func play_game():
	$Select.play()
	Transition.change_scene("res://Scenes/Levels/LevelTest.tscn")

func open_credits():
	$Select.play()
	credit_roll = true
	animation_player.play("credits")
	await animation_player.animation_finished

func quit_game():
	$Select.play()
	Transition.quit()

