extends Node

class_name State

var entity : Entity
var move_pos : Vector2 = Vector2.ZERO

func state_ready():
	pass

func physics_process(_delta : float) -> State:
	return null

func input(_event : InputEvent) -> State:
	return null

func start():
	pass

func end():
	pass
