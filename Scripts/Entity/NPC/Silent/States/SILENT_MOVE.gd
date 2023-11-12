extends STATE_MOVE

@export var foostep_time : float

var foostep_timer = 0
var footstep_scene : PackedScene

func state_ready():
	footstep_scene = preload("res://Scenes/Objects/silent_footstep.tscn")

func start():
	foostep_timer = 0
	
func physics_process(_delta : float) -> State:
	var npc = entity as NPC
	if (!npc.target) :
		return null;
		
	var retState = super.physics_process(_delta)
	if (retState):
		return retState;
	
	foostep_timer += _delta;
	if (foostep_timer >= foostep_time):
		var footstep : SilentFootstep = footstep_scene.instantiate()
		if (footstep):
			footstep.global_position = npc.global_position
			footstep.global_rotation = npc.target_direction.angle()
			entity.add_sibling(footstep)
			
			footstep.play()
			foostep_timer = 0
		else:
			push_warning("silent move didn't produce a footstep!")
	return null
