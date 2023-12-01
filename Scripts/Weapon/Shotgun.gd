extends Weapon

class_name Shotgun

var bullet_scene = preload("res://Scenes/Objects/bullet.tscn")

func _init():
	attack.atk = 3
	rate = .6
	
	sprite = preload("res://Scenes/Weapons/Shotgun.tscn").instantiate()
	UI_sel = preload("res://Sprites/GUI/HUD/Weapon/shotgun.png")
	UI_desel = preload("res://Sprites/GUI/HUD/Weapon/shotgun_desel.png")

func on_hold():
	var player : Player = GameManager.player
	
	var diff : float = deg_to_rad(10)
	var bullet1 : Vector2 = player.get_local_mouse_position()
	
	var angle1 : float = atan2(bullet1.y, bullet1.x)
	var angle2 : float = angle1 - diff
	var angle3 : float = angle1 + diff
	
	var bullet2 : Vector2 = Vector2(cos(angle2), sin(angle2))
	var bullet3 : Vector2 = Vector2(cos(angle3), sin(angle3))
	
	var atk : Attack = attack.duplicate()
	atk.atk = atk.atk * GameManager.player.size_state_manager.current_state.attack_multiplier
	
	player.shoot_bullet(bullet_scene, sprite.end_point.global_position, player.to_global(bullet1), 1, atk)
	player.shoot_bullet(bullet_scene, sprite.end_point.global_position, player.to_global(bullet2), 1, atk)
	player.shoot_bullet(bullet_scene, sprite.end_point.global_position, player.to_global(bullet3), 1, atk)
	player.audio_player.set_stream(GameManager.bullet_sfx)
	player.audio_player.play()
