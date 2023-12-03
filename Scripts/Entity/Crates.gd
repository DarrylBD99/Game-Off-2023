extends Entity

@export var sprite_var : int = 0

func _ready():
	$Sprite2D.frame = sprite_var
	super._ready()
