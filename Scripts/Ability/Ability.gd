class_name Ability

var energy_cost : float
var UI_desel : CompressedTexture2D
var UI_sel : CompressedTexture2D

func use_ability() -> bool:
	if GameManager.player.energy.energy < energy_cost:
		return false
	
	return true

func select():
	pass
