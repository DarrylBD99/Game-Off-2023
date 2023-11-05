extends Area2D
class_name Hitbox

@export var health : Health

func damage(attack : Attack):
	if health:
		health.damage(attack)
	else:
		push_warning("No HP Node")

func change_size(index : int):
	if get_parent().size_state_manager:
		var states : Array[State] = get_parent().size_state_manager.states
		if not (index >= states.size() or index < 0) and not states[index] == get_parent().size_state_manager.current_state:
			get_parent().size_state_manager.change_state(states[index])
	else:
		push_warning("No Size State Manager Node")
