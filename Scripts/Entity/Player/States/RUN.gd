extends State

@export var idle : State

func physics_process(_delta : float) -> State:
	move_pos = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	if move_pos == Vector2.ZERO:
		return idle
	
	entity.velocity = move_pos * entity.speed
	entity.update_facing_dir(move_pos)
	entity.move_and_slide()
	print(entity.animation_tree.get("parameters/Movement/blend_position"))
	return null

func start():
	entity.animation_tree.set("parameters/Movement/blend_position", 1)

func end():
	entity.animation_tree.set("parameters/Movement/blend_position", 0)
