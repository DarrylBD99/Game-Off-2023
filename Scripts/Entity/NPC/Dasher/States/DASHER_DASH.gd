extends STATE_ANIMATION

@export var DashMotion : CustomMotion
@export var idle : State

var ghost_scene : PackedScene = preload("res://Scenes/Objects/ghost_sprite.tscn")

func is_ready() -> bool:
	if not entity.target:
		return false
	
	return true
	
func start():
	super.start()
	idle.animation_player.play("DASH_BEG")
	await idle.animation_player.animation_finished
	if (entity.target):
		DashMotion.play(entity, entity.target_direction)

func end():
	super.end()
	idle.animation_player.play_backwards("DASH_BEG")
	await idle.animation_player.animation_finished

func physics_process(delta : float) -> State:
	ghost_effect()
	DashMotion.manual_process(delta)
	
	if (!DashMotion.isPlaying):
		return next_state;
	
	return null

func ghost_effect():
	var ghost : Sprite2D = ghost_scene.instantiate()
	ghost = entity.set_ghost_sprite(ghost)
	get_tree().current_scene.add_child(ghost)
