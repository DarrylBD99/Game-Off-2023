extends Panel

@export var retry_button : Button
@export var main_menu_button : Button

@export var bgm : AudioStreamPlayer

var buttons : Array[Button]

var hovering : bool = false

func _process(delta):
	if not GameManager.player and not visible:
		$AnimationPlayer.play("dead")
		GameManager.set_default()
	
	for button in buttons:
		if button.is_hovered():
			if not hovering:
				$Hover.play()
				hovering = true
				return
			else:
				return
	
	if visible and bgm:
		bgm.volume_db -= 40 * delta
		
		if bgm.volume_db < -40:
			bgm.volume_db = -40
	
	hovering = false

func _ready():
	if retry_button:
		buttons.append(retry_button)
		retry_button.pressed.connect(retry)
	
	if main_menu_button:
		buttons.append(main_menu_button)
		main_menu_button.pressed.connect(main_menu)

func retry():
	$Select.play()
	Transition.change_scene("res://Scenes/Levels/level_" + str(GameManager.level) + ".tscn")

func main_menu():
	$Select.play()
	Transition.change_scene("res://Scenes/GUI/MainMenu.tscn")

func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		main_menu()
