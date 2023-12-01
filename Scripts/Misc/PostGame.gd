extends TileMap

func _ready():
	if GameManager.game_beaten:
		queue_free()
