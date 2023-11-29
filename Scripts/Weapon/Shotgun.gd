extends Weapon

class_name Shotgun

var bullet_scene = preload("res://Scenes/Objects/bullet.tscn")

var attack_1_sfx : AudioStreamPlayer

func _init():
	attack_1_sfx = AudioStreamPlayer.new()
	attack_1_sfx.set_stream(GameManager.attack_1_audio)
	attack_1_sfx.set_bus("SFX")
	
	rate = 1.0
	
	GameManager.player.add_child(attack_1_sfx)

func on_hold():
	var player : Player = GameManager.player
	
	var bullet1 : Vector2 = player.get_global_mouse_position()
	var bullet2 : Vector2 = bullet1.rotated(deg_to_rad(5))
	var bullet3 : Vector2 = bullet1.rotated(deg_to_rad(-5))
	
	player.shoot_bullet(bullet_scene, player.global_position, bullet1, 1)
	player.shoot_bullet(bullet_scene, player.global_position, bullet2, 1)
	player.shoot_bullet(bullet_scene, player.global_position, bullet3, 1)
	attack_1_sfx.play()
