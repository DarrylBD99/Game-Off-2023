extends Entity

@export var AimRayCast : RayCast2D

var bullet_scene : PackedScene

func _ready():
	bullet_scene = preload("res://Scenes/Objects/bullet.tscn")
	super._ready()

func _physics_process(delta):
	AimRayCast.target_position = get_global_mouse_position() - global_position
	
	if Input.is_action_pressed("player_attack") and not GameManager.ability_bool and can_fire:
		shoot_bullet(bullet_scene)
	
	super._physics_process(delta)

func _input(event : InputEvent):
	if event.is_action_pressed("player_attack"):
		if GameManager.ability_bool:
			if AimRayCast.is_colliding() and AimRayCast.get_collider() is Hitbox:
				var hitbox : Hitbox = AimRayCast.get_collider()
				hitbox.change_size(0)
				GameManager.ability_bool = false
				can_fire = false
			
	if event.is_action_released("player_attack"):
		can_fire = true
