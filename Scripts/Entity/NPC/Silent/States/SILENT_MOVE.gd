extends State

@export var attack : State
@export var visuals : Sprite2D
@export var attack_range : float
@export var foostep_time : float

var foostep_timer = 0
var footstep_scene : PackedScene

func _ready():
	footstep_scene = preload("res://Scenes/Objects/silent_footstep.tscn")

func start():
	foostep_timer = 0
	visuals.hide()
	
func end():
	visuals.show()
	
func physics_process(_delta : float) -> State:
	var npc = entity as NPC
	if (!npc.target) :
		return null;

	var targetPosition = npc.target.global_position;
	var current_agent_position: Vector2 = npc.global_position	
	var new_velocity: Vector2 = targetPosition - current_agent_position
	
	# if we are close do an attack
	var distance = new_velocity.length();
	if (distance <= attack_range):
		return attack;
	
	new_velocity = new_velocity.normalized()
	#var deltaRotation = (new_velocity.angle() - visuals.rotation)
	#visuals.rotation = visuals.rotation + deltaRotation * _delta;
	entity.velocity = new_velocity * entity.speed
	entity.move_and_slide()
	
	foostep_timer += _delta;

	if (foostep_timer >= foostep_time):
		var footstep : SilentFootstep = footstep_scene.instantiate()
		if (footstep):
			footstep.global_position = current_agent_position
			footstep.global_rotation = new_velocity.angle()
			add_sibling(footstep)
			
			footstep.play()
			foostep_timer = 0
		else:
			push_warning("silent move didn't produce a footstep!")
	return null
