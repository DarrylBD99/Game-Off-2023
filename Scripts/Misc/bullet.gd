extends StaticBody2D

@export var attack : Attack
@export var hit_particle_scene : PackedScene

var cursor_pos : Vector2
var move_pos : Vector2
var bullet_speed : float = 2000
var entity_origin : Entity
var bullet_pos_old : Vector2

func _ready():
	cursor_pos = get_global_mouse_position()
	look_at(cursor_pos)
	
	move_pos = global_position.direction_to(cursor_pos)

func _physics_process(delta):
	bullet_pos_old = global_position
	
	if move_and_collide(move_pos * bullet_speed * delta):
		bullet_burst(global_position)
	
	$RayCast2D.target_position = bullet_pos_old
	
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider() is Hitbox:
			$RayCast2D.get_collider().damage(attack)
			bullet_burst($RayCast2D.get_collision_point())

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func bullet_burst(pos : Vector2):
	var hit_particle : GPUParticles2D = hit_particle_scene.instantiate()
	hit_particle.global_position = pos
	get_tree().current_scene.add_child(hit_particle)
	
	queue_free()

func _on_area_2d_area_entered(area):
	if area is Hitbox:
		area.damage(attack)
		bullet_burst(global_position)
