extends StaticBody2D

@export var attack : Attack
@export var bullet : StaticBody2D

var cursor_pos : Vector2
var move_pos : Vector2
var bullet_speed : float = 5000

func _ready():
	cursor_pos = get_global_mouse_position()
	look_at(cursor_pos)
	
	move_pos = global_position.direction_to(cursor_pos)

func _physics_process(delta):
	move_and_collide(move_pos * bullet_speed * delta)

func _on_hitbox_area_entered(area):
	if area is Hitbox:
		damage(area)

func _on_hitbox_body_entered(body):
	if body is Hitbox:
		damage(body)

func damage(hitbox : Hitbox):
	hitbox.damage(attack)
	bullet.queue_free()
