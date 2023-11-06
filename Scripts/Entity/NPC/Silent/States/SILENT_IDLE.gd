extends State

@export var next_state : State
@export var target_range : float

func physics_process(_delta : float) -> State:
	var npc = entity as NPC
	if (!npc.target) :
		return null;

	if (npc.target_distance >= target_range):
		return next_state;
	return null
