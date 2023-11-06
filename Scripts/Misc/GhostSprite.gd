extends Sprite2D

@onready var tween : Tween = get_tree().create_tween() #Creates a Tween

func _ready():
	
	# Sets transition and ease for all following tweens
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)

	# Tween to execute, 
	tween.tween_property(self,"modulate:a",0.0,0.5)
	# Extra: In my case I added this callback to a function named "finished"
	tween.tween_callback(finished)

func finished():
	queue_free()
