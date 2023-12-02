extends Control

@export var resume_button : Button
@export var main_menu_button : Button

@export var bgm : AudioStreamPlayer

var hovering : bool = false

var buttons : Array[Button]

@onready var animation_player : AnimationPlayer = $AnimationPlayer

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
	
	if bgm:
		if get_parent().paused:
			bgm.volume_db = -10
		else:
			bgm.volume_db = 0

func _ready():
	if resume_button:
		buttons.append(resume_button)
		resume_button.pressed.connect(resume)
	
	if main_menu_button:
		buttons.append(main_menu_button)
		main_menu_button.pressed.connect(main_menu)

func resume():
	$Select.play()
	get_parent().pause_resume()

func main_menu():
	$Select.play()
	Transition.change_scene("res://Scenes/GUI/MainMenu.tscn")
	get_tree().paused = false
