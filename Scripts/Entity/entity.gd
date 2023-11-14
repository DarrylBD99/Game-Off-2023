extends CharacterBody2D
class_name Entity

@export var speed : float = 100.0
@export var fire_rate : float = 0.2

@export var state_manager : StateManager
@export var action_state_manager : StateManager
@export var size_state_manager : StateManager

@export var animation_tree : AnimationTree
@export var size_time_limit : Timer

@export var health : Health
@export var attack : Attack
@export var hitbox : Hitbox

var can_fire : bool = true
var normal_size : State
var size_bool : bool = false
var flash_timer : Timer

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
		normal_size = size_state_manager.current_state
	
	flash_timer = Timer.new()
	flash_timer.wait_time = 0.1
	add_child(flash_timer)
	flash_timer.timeout.connect(_on_flash_finish)

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
		
		if size_time_limit and size_state_manager.current_state != normal_size and not size_bool:
			size_time_limit.start()
			size_bool = true
			size_time_limit.start()
	
	if size_bool and size_time_limit.is_stopped():
		var states : Array[State] = size_state_manager.states
		size_bool = false
		size_state_manager.change_state(states[states.find(normal_size)])
	
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

func shoot_bullet(bullet_scene : PackedScene, pos_origin : Vector2, pos_end : Vector2, shake : float = 0):
	if can_fire:
		GameManager.camera.shake(shake)
		
		var bullet : StaticBody2D = bullet_scene.instantiate()
		bullet.global_position = pos_origin
		bullet.look_at(pos_end)
		bullet.move_pos = global_position.direction_to(pos_end)
		bullet.entity_origin = self
		
		add_sibling(bullet)
		
		#stop rapid fire
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true


func set_ghost_sprite(ghost : Sprite2D) -> Sprite2D:
	ghost.global_position = global_position
	ghost.offset = $Sprite2D.offset
	ghost.texture = $Sprite2D.texture
	ghost.vframes = $Sprite2D.vframes
	ghost.hframes = $Sprite2D.hframes
	ghost.frame = $Sprite2D.frame
	ghost.flip_h = $Sprite2D.flip_h
	
	ghost.scale = $Sprite2D.scale * scale
	
	return ghost

func flash():
	if $Sprite2D.material and flash_timer:
		$Sprite2D.material.set_shader_parameter("flash_alpha", 1)
		flash_timer.start()

func _on_flash_finish():
	if $Sprite2D.material:
		$Sprite2D.material.set_shader_parameter("flash_alpha", 0)
