extends Ability

class_name ChangePlayerSize

var size_index : int

func use_ability() -> bool:
	var player : Entity = GameManager.player
	
	if super.use_ability():
		player.hitbox.change_size(size_index)
		return true
	
	return false

func select():
	GameManager.set_x_crosshair()
