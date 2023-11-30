extends Node

var default_cursor : CompressedTexture2D = preload("res://Sprites/GUI/cursor.png")

var crosshair : CompressedTexture2D = preload("res://Sprites/GUI/crosshair.png")
var ability_crosshair : CompressedTexture2D = preload("res://Sprites/GUI/crosshair_ability.png")
var x_crosshair : CompressedTexture2D = preload("res://Sprites/GUI/X.png")

var attack_sfx : AudioStream = preload("res://Audio/SE/Bullet.wav")
var bullet_sfx : AudioStream = preload("res://Audio/SE/Bullet.wav")
var bullet_2_sfx : AudioStream = preload("res://Audio/SE/Bullet_2.wav")
var dash_sfx : AudioStream = preload("res://Audio/SE/Dash.wav")

var cursor : CompressedTexture2D
var cursor_type : int
var cursor_hotspot : Vector2

var event_old : InputEvent
var ability_bool : bool = false

var player : Player
var camera : Camera2D

var grid_navmesh : GridNavmesh
var changing_size : bool = false
var cursor_type_str : String

@onready var random : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	set_default()
	process_mode = Node.PROCESS_MODE_ALWAYS

func set_random_seed():
	random.seed = Time.get_ticks_usec()

func set_ability_bool(active : bool):
	if player.get_current_ability():
		ability_bool = active
	else:
		ability_bool = false

func _process(_delta):
	Input.set_custom_mouse_cursor(cursor, cursor_type, cursor_hotspot)

func set_cursor(type : String):
	if type == "crosshair":
		set_crosshair()
	elif type == "ability":
		set_ability_crosshair()
	elif type == "X":
		set_x_crosshair()
	else:
		set_default()
	
	
func set_default():
	cursor = default_cursor
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(5, 5)
	cursor_type_str = String()

func set_crosshair():
	cursor = crosshair
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(18, 18)
	cursor_type_str = "crosshair"

func set_ability_crosshair():
	cursor = ability_crosshair
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(14, 14)
	cursor_type_str = "ability"

func set_x_crosshair():
	cursor = x_crosshair
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(18,18)
	cursor_type_str = "X"
