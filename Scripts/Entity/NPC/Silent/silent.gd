extends NPC

@export var melee_collision : Area2D

func _ready():
	melee_collision.area_entered.connect(area_melee_entered)
	super._ready()
	
func area_melee_entered(area: Area2D):
	area.damage(attack)

