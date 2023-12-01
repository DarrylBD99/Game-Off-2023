extends StageState

@export var slam_area2d : Area2D

var attack_finished : bool = false

func physics_process(delta : float) -> State:
	if attack_finished:
		var state_ret : State = super.physics_process(delta)
		if not state_ret:
			attack_finished = false
			attacking()
		else:
			return state_ret
	
	return null

func start():
	super.start()
	attack_finished = false
	attacking()

func state_ready():
	slam_area2d.area_entered.connect(damage)

func damage(area : Area2D):
	if area is Hitbox:
		var attack : Attack = Attack.new()
		attack.atk = 3
		area.damage(attack)
	

func attacking():
	fly_up()
	await entity.animation_player.animation_finished
	drop()
	await entity.animation_player.animation_finished
	attack_finished = true

func fly_up():
	var anim : Animation = entity.animation_player.get_animation("fly_up")
	var track_id: int = anim.find_track(".:position", Animation.TYPE_VALUE)
	
	var target_position : Vector2 = entity.global_position
	target_position.y -= 500
	
	anim.track_insert_key(track_id, 2.0, target_position)
	
	await get_tree().create_timer(0.6).timeout
	entity.animation_player.play("fly_up")

func drop():
	var anim : Animation = entity.animation_player.get_animation("drop")
	var track_id: int = anim.find_track(".:position", Animation.TYPE_VALUE)
	
	var target_position : Vector2 = entity.target.global_position
	var start_pos : Vector2 = target_position
	var end_pos : Vector2 = target_position
	end_pos.y -= 20
	
	anim.track_insert_key(track_id, 0.4, target_position)
	anim.track_insert_key(track_id, 1.4, end_pos)
	
	print("drop")
	
	entity.animation_player.play("drop")

func slam_sfx():
	entity.audio_player.set_stream(preload("res://Audio/SE/Slam.mp3").instantiate())
	entity.audio_player.play()
