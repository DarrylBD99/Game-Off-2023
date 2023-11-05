extends CharacterBody2D
class_name Entity

@export var speed : float = 100.0
@export var fire_rate : float = 0.2
@export var state_manager : StateManager
@export var action_state_manager : StateManager
@export var size_state_manager : StateManager

@export var animation_tree : AnimationTree

@export var health : Health
@export var attack : Attack

var can_fire : bool = true

func _ready():
	# Base State Machine
	if state_manager:
		state_manager.ready()
	
	# Action State Machine
	if action_state_manager:
		action_state_manager.ready()
	
	# Size State Machine
	if size_state_manager:
		size_state_manager.ready()

func _physics_process(delta):
	# Base State Machine
	if state_manager:
		state_manager.physics_process(delta)
	
	# Action State Machine
	if action_state_manager:
		action_state_manager.physics_process(delta)
	
	# Size State Machine
	if size_state_manager:
		size_state_manager.physics_process(delta)
		
func _input(event):
	# Base State Machine
	if state_manager:
		state_manager.input(event)
	
	# Action State Machine
	if action_state_manager:
		action_state_manager.input(event)
	
	# Size State Machine
	if size_state_manager:
		size_state_manager.input(event)

func shoot_bullet(bullet_scene : PackedScene):
	if can_fire:
		var bullet : StaticBody2D = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.entity_origin = self
		add_sibling(bullet)
		
		#stop rapid fire
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
