extends Entity
class_name NPC

var target_direction : Vector2
var target_distance : float
	
func _physics_process(delta):
	if GameManager.target :
		var targetPosition = GameManager.target.global_position
		var current_agent_position = global_position	
		var difference = targetPosition - current_agent_position
		target_direction = difference.normalized()
		target_distance = difference.length()
		
	super._physics_process(delta)
