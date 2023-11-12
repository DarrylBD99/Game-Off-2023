extends State
class_name STATE_MOVE

@export var next_state : State
@export var target_range : float

func is_ready() -> bool:
	var npc = entity as NPC
	if (!npc || !npc.target) :
		return false;

	return npc.target_distance > target_range

func end():
	entity.velocity = Vector2(0, 0)
	
func physics_process(_delta : float) -> State:
	var npc = entity as NPC
	if (!npc.target) :
		return null;

	if (npc.target_distance <= target_range):
		return next_state;
	
	entity.velocity = npc.target_direction * entity.speed
	entity.move_and_slide()

	return null
