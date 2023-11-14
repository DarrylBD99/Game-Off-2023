extends State

@export var target_range : float
@export var idle : State

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
	
	return range_bool and not block_bool and GameManager.target

func physics_process(delta : float) -> State:
	range_bool = entity.target_distance < target_range
	block_bool = entity.AimRayCast.is_colliding()
	
	if not GameManager.target:
		return idle
	
	var pos : Vector2 = GameManager.target.global_position - entity.global_position
	var adjacent : float = pos.x
	var opposite : float = pos.y
	
	var rotate_to : float = atan2(opposite, adjacent)
	
	entity.barrel.rotation = lerp_angle(entity.barrel.rotation, rotate_to, delta * 10)
	
	if entity.can_fire:
		entity.shoot_bullet(entity.bullet_scene, entity.barrel_end.global_position, GameManager.target.global_position)
		
		audio_stream_player.play()
	
	if not (range_bool and not block_bool):
		return idle
	
	return null
