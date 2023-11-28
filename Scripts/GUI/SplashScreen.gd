extends Control

var old_size : Vector2i
var preffered_size : Vector2i = Vector2i(1920, 1080)

func _ready():
	old_size = get_viewport().get_visible_rect().size
	get_viewport().set_content_scale_size(preffered_size)
	print(get_viewport().get_visible_rect().size)

func open_main_menu():
	ResourceLoader.load_threaded_request("res://Scenes/GUI/MainMenu.tscn")
	get_viewport().set_content_scale_size(old_size)
	print(get_viewport().get_visible_rect().size)
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://Scenes/GUI/MainMenu.tscn"))
	
