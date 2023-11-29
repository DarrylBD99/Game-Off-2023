extends CanvasLayer

@export var pause_menu : Control
@export var animation_player : AnimationPlayer

@onready var cursor_type : String = GameManager.cursor_type_str

@onready var paused : bool = get_tree().paused

func set_game_pause():
	get_tree().paused = paused

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_resume()

func pause_resume():
	paused = not get_tree().paused
	
	if paused:
		cursor_type = GameManager.cursor_type_str
		GameManager.set_default()
		
		animation_player.play("PauseMenu")
		await animation_player.animation_finished
	else:
		GameManager.set_cursor(cursor_type)
		animation_player.play_backwards("PauseMenu")
		await animation_player.animation_finished
