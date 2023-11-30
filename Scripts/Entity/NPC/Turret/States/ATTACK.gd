extends State

@export var target_range : float
@export var idle : State
@export var fire_rate : float = 0.5

var can_fire : bool = true
var range_bool : bool
var block_bool : bool

var audio_stream_player : AudioStreamPlayer2D

func state_ready():
	audio_stream_player = AudioStreamPlayer2D.new()
	
	audio_stream_player.set_stream(GameManager.bullet_sfx)
	audio_stream_player.set_bus("SFX")
	entity.add_child(audio_stream_player)

func is_ready() -> bool:
	range_bool = entity.target_distance < target_range
	block_bool = entity.AimRayCast.is_colliding()
	return range_bool and not block_bool and entity.target

func physics_process(delta : float) -> State:
	range_bool = entity.target_distance < target_range
	block_bool = entity.AimRayCast.is_colliding()
	
	if not entity.target:
		return idle
	
	if can_fire:
		var angle : float = entity.barrel.rotation
		
		if angle < 0:
			while angle < 0:
				angle += (2 * PI)
		
		elif angle >= (2 * PI):
			while (angle >= (2 * PI)):
				angle -= (2 * PI)
		
		var fire_pos : Vector2 = Vector2(cos(angle), sin(angle))
		
		entity.shoot_bullet(entity.bullet_scene, entity.barrel_end.global_position, entity.to_global(fire_pos))
		
		#stop rapid fire
		can_fire = false
		get_tree().create_timer(fire_rate).timeout.connect(reset_fire)
		
		audio_stream_player.play()
	
	var pos : Vector2 = entity.target.global_position - entity.global_position
	var rotate_to : float = atan2(pos.y, pos.x)
	
	entity.barrel.rotate(lerp_angle(entity.barrel.rotation, rotate_to, delta * 5) - entity.barrel.rotation)
	
	if not (range_bool and not block_bool):
		return idle
	
	return null

func reset_fire():
	can_fire = true
