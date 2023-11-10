extends GPUParticles2D

func _ready():
	set_emitting(true)

func _on_timer_timeout():
	queue_free()
