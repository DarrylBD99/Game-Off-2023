extends CharacterBody2D

@export var speed : float

var bullet_scene : PackedScene = preload("res://Scenes/Objects/bullet.tscn")

func _physics_process(_delta):
	var move_pos : Vector2 = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	velocity = move_pos * speed
	move_and_slide()

func _input(event : InputEvent):
	if event.is_action_pressed("player_attack"):
		var bullet : StaticBody2D = bullet_scene.instantiate()
		bullet.global_position = global_position
		add_sibling(bullet)
