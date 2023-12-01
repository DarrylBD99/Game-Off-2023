extends Control

@export var play_button : Button
@export var help_button : Button
@export var credit_button : Button
@export var quit_button : Button

@export var animation_player : AnimationPlayer
@export var help_panel : Control

var credit_roll : bool = false
var hovering : bool = false

var buttons : Array[Button]

func _ready():
	GameManager.set_default()
	
	if help_panel:
		help_panel.hide()
	
	if play_button:
		buttons.append(play_button)
		play_button.pressed.connect(play_game)
		
	if help_button:
		buttons.append(help_button)
		help_button.pressed.connect(help_menu)
	
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
	Transition.change_scene("res://Scenes/Levels/level_" + str(GameManager.level) + ".tscn")

func help_menu():
	if help_panel:
		help_panel.show()

func open_credits():
	$Select.play()
	credit_roll = true
	animation_player.play("credits")
	await animation_player.animation_finished

func quit_game():
	$Select.play()
	Transition.quit()

