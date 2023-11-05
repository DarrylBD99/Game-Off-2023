extends Node

class_name StateManager

@export var current_state : State

@onready var entity : Entity = get_parent()

var states : Array[State]

func ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			# set states up with appropriate function
			child.entity = entity
			child.state_ready()
		else:
			push_warning("Child " + child.name + " is not a State class")

	current_state.start()

func physics_process(delta):
	var next_state : State = current_state.physics_process(delta)
	
	change_state(next_state)

func input(event):
	var next_state : State = current_state.input(event)
	
	change_state(next_state)

func can_move() -> bool:
	return current_state.can_move

func change_state(new_state : State):
	if new_state != null:
		current_state.end()
		
		current_state = new_state
		current_state.start()
