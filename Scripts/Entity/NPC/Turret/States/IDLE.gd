extends IDLE_State

var random_rotate : float
@export var animationPlayer : AnimationPlayer

func physics_process(delta : float) -> State:
	if entity.rotate_timer.is_stopped():
		GameManager.set_random_seed()
		random_rotate = GameManager.random.randi_range(0, 359)
		entity.rotate_timer.start()
	
	entity.barrel.rotation = lerp_angle(entity.barrel.rotation, random_rotate, delta * 10)
	
	return super.physics_process(delta)

func start():
	random_rotate = entity.barrel.rotation
	await animationPlayer.animation_finished
	animationPlayer.play("to_idle")
	await animationPlayer.animation_finished
	entity.rotate_timer.start()

func end():
	entity.rotate_timer.stop()
