extends GPUParticles2D

var alive_time : float

func _ready():
	alive_time = lifetime
	get_tree().create_timer(alive_time).timeout.connect(queue_free)
	set_emitting(true)
