extends Node
class_name  GridNavmesh

@export var tile_map : TileMap

var astar_grid: AStarGrid2D

func generate_path(start: Vector2, end: Vector2) -> PackedVector2Array:
	var local_start = project_to_grid(start)
	var local_end =  project_to_grid(end)
	var id_path =  astar_grid.get_id_path(local_start, local_end)
	var world_path = PackedVector2Array()
	for id in id_path:
		world_path.push_back(tile_map.map_to_local(id))
	return world_path

# find the closest point that's on a valid grid position
func project_to_grid(point: Vector2) -> Vector2i:
	var local_point = tile_map.local_to_map(point)
	if (!astar_grid.is_point_solid(local_point)):
		return local_point;
		
	var projection_directions = [
		Vector2i(1, 0), 
		Vector2i(-1, 0),
		Vector2i(0, 1), 
		Vector2i(0, -1),
		Vector2i(1, 1), 
		Vector2i(-1, -1),
		Vector2i(-1, 1),
		Vector2i(1, -1)]
	
	var custom_sort = func (a, b):
		var world_a = tile_map.map_to_local(a + local_point)
		var world_b = tile_map.map_to_local(b + local_point)
		
		var distance_a = world_a.distance_squared_to(point)
		var distance_b = world_b.distance_squared_to(point)
		
		return distance_a <= distance_b
	
	projection_directions.sort_custom(custom_sort)
	
	for direction in projection_directions:
		var offset_point = local_point + direction
		if (!astar_grid.is_point_solid(offset_point)):
			return offset_point
		
	push_warning("Couldn't find a point on the grid...")
	return local_point
			
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.grid_navmesh = self
		
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	var tile_size = tile_map.tile_set.tile_size
	astar_grid.cell_size = Vector2(tile_size.x, tile_size.y)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.update()
	
	for layer_id in range(tile_map.get_layers_count()):
		for tile in tile_map.get_used_cells(layer_id):
			# if this tile has any collision mark this as inpassable		
			var tiledata = tile_map.get_cell_tile_data(layer_id, tile)
			var point_amount = tiledata.get_collision_polygons_count(0)
			if (point_amount > 0):
				astar_grid.set_point_solid(tile)
