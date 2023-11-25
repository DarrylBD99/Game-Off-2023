extends State

@export var IDLE : State

@export var dash_timer : Timer

@export var dash_speed_multiplier : float = 5.0

var dash_vel : Vector2 = Vector2.ZERO
var original_collision_mask : int
var ghost_scene : PackedScene = preload("res://Scenes/Objects/ghost_sprite.tscn")

func physics_process(_delta) -> State:
	if dash_timer.is_stopped():
		entity.velocity = Vector2.ZERO
		entity.dash_bool = false
		return IDLE
	
	entity.animation_tree.set("parameters/conditions/dash_bool", entity.dash_bool)
	entity.animation_tree.set("parameters/conditions/normal bool", not entity.dash_bool)
	
	ghost_effect()
	entity.velocity = dash_vel
	entity.move_and_slide()
	entity.update_facing_dir(dash_vel)
	
	return null

func start():
	entity.collision_mask -= 16
	dash_timer.start()
	dash_vel = sign(entity.get_global_mouse_position() - entity.global_position) * entity.speed * dash_speed_multiplier

func end():
	entity.collision_mask = original_collision_mask
	entity.animation_tree.set("parameters/conditions/dash_bool", entity.dash_bool)
	entity.animation_tree.set("parameters/conditions/normal bool", not entity.dash_bool)

func ghost_effect():
	var ghost : Sprite2D = ghost_scene.instantiate()
	ghost = entity.set_ghost_sprite(ghost)
	get_tree().current_scene.add_child(ghost)

func colliding_entity(area: Area2D):
	if area is Hitbox and entity.dash_bool:
		area.damage(entity.attack)

func state_ready():
	original_collision_mask = entity.collision_mask
	entity.hitbox.area_entered.connect(colliding_entity)
