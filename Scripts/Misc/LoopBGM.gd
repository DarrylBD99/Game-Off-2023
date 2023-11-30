extends AudioStreamPlayer

@export var loop_strat : AudioStream
@export var loop : AudioStream

func _ready():
	if loop_strat:
		set_stream(loop_strat)
		play()
	elif loop:
		set_stream(loop)
		play()

func _on_finished():
	if loop:
		set_stream(loop)
		play()
