extends STATE_ANIMATION

@export var DashMotion : CustomMotion
@export var target_range : float

var ghost_scene : PackedScene = preload("res://Scenes/Objects/ghost_sprite.tscn")

func is_ready() -> bool:
	if not GameManager.target:
		return false
	
	return entity.target_distance < target_range
	
func start():
	super.start()
	
	if (GameManager.target):
		DashMotion.play(entity, entity.target_direction)

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
