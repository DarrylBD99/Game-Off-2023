extends Entity
class_name NPC

@export var debug_path = false

var target_direction : Vector2
var target_distance : float

var current_path: PackedVector2Array
var navigation_position : Vector2
var navigation_direction : Vector2

func _draw():
	if debug_path:
		for index in range(current_path.size() - 1):
			draw_line(
				current_path[index] - global_position, 
				current_path[index + 1 ]- global_position, 
				Color.RED, 
				1)
					
func _physics_process(delta):
	if GameManager.target :
		var target_position = GameManager.target.global_position
		var current_agent_position = global_position	
		var difference = target_position - current_agent_position
		target_direction = difference.normalized()
		target_distance = difference.length()
		
		if (GameManager.grid_navmesh):
			var path  = GameManager.grid_navmesh.generate_path(
				current_agent_position, 
				target_position)
				
			if (path.size() > 0):
				current_path = path
				navigation_position = current_path[1]
				navigation_direction = (navigation_position - current_agent_position).normalized()
			
	queue_redraw()
	super._physics_process(delta)

