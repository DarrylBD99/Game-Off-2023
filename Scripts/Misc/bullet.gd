extends StaticBody2D

@export var attack : Attack

var cursor_pos : Vector2
var move_pos : Vector2
var bullet_speed : float = 5000
var entity_origin : Entity

func _ready():
	cursor_pos = get_global_mouse_position()
	look_at(cursor_pos)
	
	move_pos = global_position.direction_to(cursor_pos)

func _physics_process(delta):
	move_and_collide(move_pos * bullet_speed * delta)

func _on_hitbox_area_entered(area):
	if area is Hitbox:
		area.damage(attack)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
