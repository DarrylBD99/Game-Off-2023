extends Node
class_name  GridNavmesh

@export var tile_map : TileMap
@export var layer_id : int

var astar_grid: AStarGrid2D

func generate_path(start: Vector2, end: Vector2) -> PackedVector2Array:
	var local_start = tile_map.local_to_map(start)
	var local_end = tile_map.local_to_map(end)
	var id_path =  astar_grid.get_id_path(local_start, local_end)
	var world_path = PackedVector2Array()
	for id in id_path:
		world_path.push_back(tile_map.map_to_local(id))
	return world_path
			
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.grid_navmesh = self
		
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	var tile_size = tile_map.tile_set.tile_size
	astar_grid.cell_size = Vector2(tile_size.x, tile_size.y)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ALWAYS
	astar_grid.update()
	
	for tile in tile_map.get_used_cells(layer_id):
		# if this tile has any collision mark this as inpassable		
		var tiledata = tile_map.get_cell_tile_data(layer_id, tile)
		var point_amount = tiledata.get_collision_polygons_count(0)
		if (point_amount > 0):
			astar_grid.set_point_solid(tile)
