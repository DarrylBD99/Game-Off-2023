extends TextureProgressBar

func _process(_delta):
	if GameManager.player:
		print(value, "/", max_value)
		max_value = GameManager.player.health.hp_max
		value = GameManager.player.health.hp
