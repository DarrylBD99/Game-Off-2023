extends STATE_ANIMATION

func is_ready() -> bool:
	if not entity.target:
		return false
	
	return not entity.AimRayCast.is_colliding()

func physics_process(delta : float) -> State:
	if not (entity.target and not entity.AimRayCast.is_colliding()):
		return next_state
	
	var pos : Vector2 = entity.target.global_position - entity.global_position
	var rotate_to : float = atan2(pos.y, pos.x)
	
	entity.barrel.rotate(lerp_angle(entity.barrel.rotation, rotate_to, delta * 5) - entity.barrel.rotation)
	return super.physics_process(delta)

func fire():
	var angle : float = entity.barrel.rotation
	var fire_pos : Vector2 = Vector2(cos(angle), sin(angle))
	
	entity.shoot_bullet(entity.bullet_scene, entity.barrel_end.global_position, entity.to_global(fire_pos))
	entity.audio_player.set_stream(GameManager.bullet_2_sfx)
	entity.audio_player.play()

func start():
	animationPlayer.play("load")
	await animationPlayer.animation_finished
	super.start()
