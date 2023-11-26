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
	
	audio_stream_player.set_stream(GameManager.attack_1_audio)
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
	
	var pos : Vector2 = entity.target.global_position - entity.global_position
	var adjacent : float = pos.x
	var opposite : float = pos.y
	
	var rotate_to : float = atan2(opposite, adjacent)
	
	entity.barrel.rotation = lerp_angle(entity.barrel.rotation, rotate_to, delta * 10)
	
	if can_fire:
		entity.shoot_bullet(entity.bullet_scene, entity.barrel_end.global_position, entity.target.global_position)
		
		#stop rapid fire
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
		
		audio_stream_player.play()
	
	if not (range_bool and not block_bool):
		return idle
	
	return null
