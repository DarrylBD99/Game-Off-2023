extends Weapon

class_name Pistol

var bullet_scene = preload("res://Scenes/Objects/bullet.tscn")

var attack_1_sfx : AudioStreamPlayer

func _init():
	attack_1_sfx = AudioStreamPlayer.new()
	attack_1_sfx.set_stream(GameManager.attack_1_audio)
	attack_1_sfx.set_bus("SFX")
	
	rate = .2
	
	GameManager.player.add_child(attack_1_sfx)

func on_hold():
	var player : Player = GameManager.player
	
	player.shoot_bullet(bullet_scene, player.global_position, player.get_global_mouse_position(), 1)
	attack_1_sfx.play()
