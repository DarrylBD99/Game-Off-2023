extends Node

var default_cursor : CompressedTexture2D = preload("res://Sprites/GUI/cursor.png")

var crosshair : CompressedTexture2D = preload("res://Sprites/GUI/crosshair.png")
var ability_crosshair : CompressedTexture2D = preload("res://Sprites/GUI/crosshair_ability.png")
var x_crosshair : CompressedTexture2D = preload("res://Sprites/GUI/X.png")

var attack_1_audio : AudioStream = preload("res://Audio/SE/Attack1.wav")

var cursor : CompressedTexture2D
var cursor_type : int
var cursor_hotspot : Vector2

var event_old : InputEvent
var ability_bool : bool = false
var in_game : bool = true

var player : Player
var camera : Camera2D

var grid_navmesh : GridNavmesh
var changing_size : bool = false

@onready var random : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	set_crosshair()

func set_random_seed():
	random.seed = Time.get_ticks_usec()

func set_ability_bool(active : bool):
	if player.get_current_ability():
		ability_bool = active
	else:
		ability_bool = false

func _process(_delta):
	Input.set_custom_mouse_cursor(cursor, cursor_type, cursor_hotspot)

func set_default():
	cursor = default_cursor
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(5, 5)

func set_crosshair():
	cursor = crosshair
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(18, 18)

func set_ability_crosshair():
	cursor = ability_crosshair
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(14, 14)

func set_x_crosshair():
	cursor = x_crosshair
	cursor_type = Input.CURSOR_ARROW
	cursor_hotspot = Vector2(18,18)
