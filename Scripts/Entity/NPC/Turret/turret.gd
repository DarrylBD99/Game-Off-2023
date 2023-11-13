extends NPC

@export var AimRayCast : RayCast2D
@export var barrel : Node
@export var barrel_end : Node
@export var rotate_timer : Timer

@onready var bullet_scene : PackedScene = preload("res://Scenes/Objects/bullet.tscn")

func _physics_process(delta):
	if GameManager.target:
		AimRayCast.target_position = GameManager.target.global_position - global_position
	
	super._physics_process(delta)
