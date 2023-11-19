extends Entity
class_name NPC

@export var aggro_range : float = 300
@export var debug_path = true
#@export var navigation_agent : NavigationAgent2D

var target: Entity

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
	update_sensor()
	update_target()
	update_navigation()
	
	queue_redraw()
	super._physics_process(delta)


func update_sensor():
	target = null
	if (GameManager.player):
		var distance = global_position.distance_to(GameManager.player.global_position)
		if (distance <= aggro_range):
			target = GameManager.player

func update_target():
	if target:
#		navigation_agent.target_position = target.global_position
		
		var target_position = target.global_position
		var difference = target_position - global_position
		target_direction = difference.normalized()
		target_distance = difference.length()

func update_navigation():
#	if target:
#		navigation_direction = to_local(navigation_agent.get_next_path_position()).normalized
	if GameManager.grid_navmesh && target:
		var path  = GameManager.grid_navmesh.generate_path(
			global_position, 
			target.global_position)
		
		if (path.size() > 1):
			current_path = path
			navigation_position = current_path[1]
			navigation_direction = (navigation_position - global_position).normalized()

