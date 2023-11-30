extends Weapon

class_name Pistol

var bullet_scene = preload("res://Scenes/Objects/bullet.tscn")

var bullet_sfx : AudioStreamPlayer

func _init():
	bullet_sfx = AudioStreamPlayer.new()
	bullet_sfx.set_stream(GameManager.bullet_sfx)
	bullet_sfx.set_bus("SFX")
	
	rate = .2
	
	GameManager.player.add_child(bullet_sfx)

func on_hold():
	var player : Player = GameManager.player
	
	player.shoot_bullet(bullet_scene, player.global_position, player.get_global_mouse_position(), 1)
	attack_1_sfx.play()
