extends STATE_ANIMATION

@export var DashMotion : CustomMotion
@export var target_range : float

func is_ready() -> bool:
	var npc = entity as NPC
	if (!npc.target) :
		return false;

	return npc.target_distance < target_range
	
func start():
	super.start()
	var npc = entity as NPC
	if (npc.target) :
		DashMotion.play(entity, npc.target_direction)

func physics_process(_delta : float) -> State:
	DashMotion.manual_process(_delta)
	
	if (!DashMotion.isPlaying):
		return next_state;
	
	return null
