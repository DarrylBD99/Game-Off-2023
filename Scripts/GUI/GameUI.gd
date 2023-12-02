extends CanvasLayer

@export var pause_menu : Control

@onready var cursor_type : String = GameManager.cursor_type_str

@onready var paused : bool = get_tree().paused

func set_game_pause():
	get_tree().paused = paused

func _input(event):
	if not GameManager.block_input and event.is_action_pressed("ui_cancel"):
		pause_resume()

func pause_resume():
	paused = not get_tree().paused
	
	if paused:
		set_game_pause()
		cursor_type = GameManager.cursor_type_str
		GameManager.set_default()
		
		pause_menu.animation_player.play("PauseMenuAnim")
		await pause_menu.animation_player.animation_finished
	else:
		GameManager.set_cursor(cursor_type)
		pause_menu.animation_player.play_backwards("PauseMenuAnim")
		await pause_menu.animation_player.animation_finished
		set_game_pause()
