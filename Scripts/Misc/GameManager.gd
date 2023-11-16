extends Node

var default_cursor : CompressedTexture2D = preload("res://Sprites/GUI/cursor.png")

var crosshair : CompressedTexture2D = preload("res://Sprites/GUI/crosshair.png")
var ability_crosshair : CompressedTexture2D = preload("res://Sprites/GUI/crosshair_ability.png")

var attack_1_audio : AudioStream = preload("res://Audio/SE/Attack1.wav")

var cursor : CompressedTexture2D
var cursor_type : int
var cursor_hotspot : Vector2

var event_old : InputEvent
var ability_bool : bool = false
var in_game : bool = true

var target : Entity
var camera : Camera2D

var grid_navmesh : GridNavmesh

@onready var random : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	set_crosshair()

func set_random_seed():
	random.seed = Time.get_ticks_usec()

func _process(_delta):
	Input.set_custom_mouse_cursor(cursor, cursor_type, cursor_hotspot)
	
	if in_game:
		if ability_bool:
			set_ability_crosshair()
		else:
			set_crosshair()

func _input(event : InputEvent):
	if not event_old == event:
		if event.is_action_pressed("player_ability"):
			ability_bool = not ability_bool
		event_old = event

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
