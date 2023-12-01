extends StageState

@export var fire_rate : float
@export var rotation_diff : int

@export var barrel : Node2D
@export var barrel_end : Node2D

@onready var bullet_scene : PackedScene = preload("res://Scenes/Objects/bullet_boss.tscn")

var can_fire : bool = true
var rotation : float = 0

func physics_process(delta : float) -> State:
	barrel.rotate(deg_to_rad(rotation_diff))
	rotation += rotation_diff
	if can_fire:
		can_fire = false
		
		var fire_pos : Vector2 = Vector2(cos(barrel.rotation), sin(barrel.rotation))
		entity.shoot_bullet(bullet_scene, barrel_end.global_position, entity.to_global(fire_pos), 3)
		get_tree().create_timer(fire_rate).timeout.connect(enable_fire)
		
		entity.audio_player.set_stream(GameManager.bullet_2_sfx)
		entity.audio_player.play()
	
	if rotation >= 360:
		rotation = 0
		return super.physics_process(delta)
	
	return null

func start():
	rotation = 0
	super.start()

func enable_fire():
	can_fire = true
