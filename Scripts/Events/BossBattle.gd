extends Area2D

@export var animation_player : AnimationPlayer
@export var boss_spawn : Node2D
@export var remote_transform_2D_track : String
@export var player_pos_track : String
@export var temp_tilemap : TileMap
@export var acid_particle_node : Node2D
@export var acid_sfx : AudioStreamPlayer2D

var acid_particles : Array[GPUParticles2D]
var scientist_scene : PackedScene = preload("res://Scenes/Objects/Entity/scientist.tscn")

func _ready():
	for child in acid_particle_node.get_children():
		acid_particles.append(child)

func spawn_acid():
	acid_sfx.autoplay = true
	acid_sfx.play()
	for acid in acid_particles:
		acid.emitting = true

func delete_bridge():
	temp_tilemap.add_sibling(preload("res://Scenes/tile_map.tscn").instantiate())
	temp_tilemap.queue_free()
	
	var wait_time : float = 0
	for acid in acid_particles:
		acid.emitting = false
		wait_time = acid.lifetime
	
	acid_sfx.queue_free()
	
	await get_tree().create_timer(wait_time).timeout
	
	for acid in acid_particles:
		acid.queue_free()

func _on_body_entered(body):
	GameManager.block_input = true
	
	var anim : Animation = animation_player.get_animation("BossBattle")
	var track_id: int = anim.find_track(remote_transform_2D_track, Animation.TYPE_VALUE)
	
	var new_position : Vector2 = GameManager.player.to_local(boss_spawn.global_position)
	new_position.x -= 64
	anim.track_insert_key(track_id, 4.0, new_position)
	anim.track_insert_key(track_id, 13.5, new_position)
	
	track_id = anim.find_track(player_pos_track, Animation.TYPE_VALUE)
	
	new_position = GameManager.player.global_position
	new_position.x += 64
	anim.track_insert_key(track_id, 0.0, GameManager.player.global_position)
	anim.track_insert_key(track_id, 0.6, new_position)
	
	animation_player.play("BossBattle")
	await animation_player.animation_finished
	GameManager.block_input = false
