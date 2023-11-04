extends ProgressBar

@export var health : Health

func _process(_delta):
	value = health.hp / health.hp_max * 100
