extends NPC

@export var AimRayCast : RayCast2D
@export var barrel : Node
@export var barrel_end : Node
@export var rotate_timer : Timer

@onready var bullet_scene : PackedScene = preload("res://Scenes/Objects/bullet.tscn")

func _physics_process(delta):
	if target:
		AimRayCast.target_position = target.global_position - global_position
	
	super._physics_process(delta)

func flash():
	var barrel_sprite : Sprite2D = barrel.get_node_or_null("Sprite2D")
	
	if barrel_sprite and barrel_sprite.material:
		barrel_sprite.material.set_shader_parameter("flash_alpha", 1)
		
	super.flash()

func _on_flash_finish():
	var barrel_sprite : Sprite2D = barrel.get_node_or_null("Sprite2D")
	
	if barrel_sprite and barrel_sprite.material:
		barrel_sprite.material.set_shader_parameter("flash_alpha", 0)
	
	super._on_flash_finish()
