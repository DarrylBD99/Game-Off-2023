extends Weapon

class_name Shotgun

var bullet_scene = preload("res://Scenes/Objects/bullet.tscn")

var bullet_sfx : AudioStreamPlayer

func _init():
	bullet_sfx = AudioStreamPlayer.new()
	bullet_sfx.set_stream(GameManager.bullet_sfx)
	bullet_sfx.set_bus("SFX")
	
	rate = 1.0
	
	GameManager.player.add_child(bullet_sfx)

func on_hold():
	var player : Player = GameManager.player
	
	var diff : float = deg_to_rad(5)
	var bullet1 : Vector2 = player.get_global_mouse_position()
	
	var angle1 : float = atan2(bullet1.y, bullet1.x)
	var angle2 : float = angle1 - diff
	var angle3 : float = angle1 + diff
	
	var bullet2 : Vector2 = player.to_global(Vector2(cos(angle2), sin(angle2)))
	var bullet3 : Vector2 = player.toa_global(Vector2(cos(angle3), sin(angle3)))
	
	player.shoot_bullet(bullet_scene, player.global_position, bullet1, 3)
	player.shoot_bullet(bullet_scene, player.global_position, bullet2)
	player.shoot_bullet(bullet_scene, player.global_position, bullet3)
	attack_1_sfx.play()
