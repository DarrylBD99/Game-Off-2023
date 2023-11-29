extends Control

@export var resume_button : Button
@export var main_menu_button : Button

@export var hover : AudioStreamPlayer2D
@export var select : AudioStreamPlayer2D

var hovering : bool = false

var buttons : Array[Button]

func _process(_delta):
	for button in buttons:
		if button.is_hovered():
			if not hovering:
				hover.play()
				hovering = true
				return
			else:
				return
	
	hovering = false
	

func _ready():
	if resume_button:
		buttons.append(resume_button)
		resume_button.pressed.connect(resume)
	
	if main_menu_button:
		buttons.append(main_menu_button)
		main_menu_button.pressed.connect(main_menu)

func resume():
	select.play()
	get_parent().pause_resume()

func main_menu():
	select.play()
	Transition.change_scene("res://Scenes/GUI/MainMenu.tscn")
	get_tree().paused = false
