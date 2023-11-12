extends Entity
class_name NPC

@export var target : Entity

var target_direction : Vector2
var target_distance : float
	
func _physics_process(delta):
	if ( weakref(target)) :
		var targetPosition = target.global_position
		var current_agent_position = global_position	
		var difference = targetPosition - current_agent_position
		target_direction = difference.normalized()
		target_distance = difference.length()
		
	super._physics_process(delta)
