extends StaticBody2D

@export var hit_particle_scene : PackedScene
@export var bullet_speed : float = 1800

var cursor_pos : Vector2
var move_pos : Vector2
var entity_origin : Entity
var bullet_pos_old : Vector2
var hit : bool = false
var attack : Attack

func _physics_process(delta):
	bullet_pos_old = global_position
	
	if move_and_collide(move_pos * bullet_speed * delta):
		bullet_burst(global_position)
	
	$RayCast2D.target_position = bullet_pos_old - global_position
	
	if $RayCast2D.is_colliding():
		var collide = $RayCast2D.get_collider()
		if collide is Hitbox and not collide == entity_origin.hitbox and not hit:
			collide.damage(attack)
			hit = true
			bullet_burst($RayCast2D.get_collision_point())

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func bullet_burst(pos : Vector2):
	var hit_particle : GPUParticles2D = hit_particle_scene.instantiate()
	hit_particle.global_position = pos
	get_tree().current_scene.add_child(hit_particle)
	
	queue_free()

func _on_area_2d_area_entered(area):
	if area is Hitbox and not area == entity_origin.hitbox and not hit:
		area.damage(attack)
		hit = true
		bullet_burst(global_position)
