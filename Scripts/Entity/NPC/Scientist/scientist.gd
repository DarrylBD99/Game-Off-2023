extends NPC

@export var animation_player : AnimationPlayer
@export var animation_player_2 : AnimationPlayer

@export var dust_scene : PackedScene
@export var dust_impact_scene : PackedScene

@export var dust_origin : Node2D
@export var dust_origin_2 : Node2D

@export var laugh_sfx : AudioStream
@export var ship_sfx : AudioStream

var hostile : bool = false

var dust : GPUParticles2D
var dust_impact : GPUParticles2D

func enable_hostile():
	hostile = true

func update_sensor():
	target = null
	if hostile and GameManager.player:
		target = GameManager.player

func cooldown():
	var anim : Animation = animation_player.get_animation("cooldown_start")
	var track_id: int = anim.find_track(".:position", Animation.TYPE_VALUE)
	
	var new_position : Vector2 = Vector2(global_position.x, global_position.y + 10)
	
	anim.track_insert_key(track_id, 0, global_position)
	anim.track_insert_key(track_id, 2.0, new_position)
	
	dust_particles_on()
	audio_player.set_stream(ship_sfx)
	audio_player.autoplay = true
	audio_player.play()
	animation_player.play("cooldown_start")

func cooldown_end():
	var anim : Animation = animation_player.get_animation("cooldown_end")
	var track_id: int = anim.find_track(".:position", Animation.TYPE_VALUE)
	
	var new_position : Vector2 = Vector2(global_position.x, global_position.y - 10)
	
	anim.track_insert_key(track_id, 0, global_position)
	anim.track_insert_key(track_id, 1.2, new_position)
	anim.track_insert_key(track_id, 1.8, Vector2(dust_origin_2.global_position.x, dust_origin_2.global_position.y - 32))
	dust_origin_2
	dust_particles_off()
	stop_sfx()
	animation_player.play("cooldown_end")
	await animation_player.animation_finished
	animation_player.play("idle")

func ship_sfx_start():
	audio_player.set_stream(ship_sfx)
	animation_player_2.play("ship_start")
	audio_player.autoplay = true
	audio_player.play()

func stop_sfx():
	audio_player.autoplay = false
	audio_player.stop()

func laugh():
	audio_player.set_stream(laugh_sfx)
	audio_player.play()
	animation_player.play("Laugh")
	await audio_player.finished
	animation_player.play("IDLE")

func dust_particles_on():
	dust = dust_scene.instantiate()
	add_sibling(dust)
	dust.global_position = dust_origin.global_position
	dust.set_emitting(true)

func dust_particles_on_2():
	dust = dust_scene.instantiate()
	add_sibling(dust)
	dust.global_position = dust_origin_2.global_position
	dust.set_emitting(true)

func dust_particles_off():
	dust.set_emitting(false)
	get_tree().create_timer(dust.lifetime).timeout.connect(dust.queue_free)

func spawn_dust_impact():
	dust_impact = dust_impact_scene.instantiate()
	add_child(dust_impact)
	dust_impact.global_position = dust_origin.global_position

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		GameManager.level = 1
		Transition.change_scene("res://Scenes/GUI/EndOfDemo.tscn")
