extends State

@export var target_range : float
@export var idle : State

var range_bool : bool
var block_bool : bool

func is_ready() -> bool:
	range_bool = entity.target_distance < target_range
	block_bool = entity.AimRayCast.is_colliding()
	
	return range_bool and not block_bool

func physics_process(delta : float) -> State:
	range_bool = entity.target_distance < target_range
	block_bool = entity.AimRayCast.is_colliding()
	
	if not GameManager.target:
		return null
	
	var pos : Vector2 = GameManager.target.global_position - entity.global_position
	var adjacent : float = pos.x
	var opposite : float = pos.y
	
	var rotate_to : float = atan2(opposite, adjacent)
	
	entity.barrel.rotation = lerp_angle(entity.barrel.rotation, rotate_to, delta * 10)
	
	if entity.can_fire:
		entity.shoot_bullet(entity.bullet_scene, entity.barrel_end.global_position, GameManager.target.global_position)
	
	if not (range_bool and not block_bool):
		return idle
	
	return null
