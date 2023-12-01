extends Weapon

class_name Pistol

var bullet_scene = preload("res://Scenes/Objects/bullet.tscn")

func _init():
	attack.atk = 2
	rate = .2
	
	sprite = preload("res://Scenes/Weapons/Pistol.tscn").instantiate()
	UI_sel = preload("res://Sprites/GUI/HUD/Weapon/pistol.png")
	UI_desel = preload("res://Sprites/GUI/HUD/Weapon/pistol_desel.png")


func on_hold():
	var player : Player = GameManager.player
	
	var atk : Attack = attack.duplicate()
	atk.atk = atk.atk * GameManager.player.size_state_manager.current_state.attack_multiplier
	
	player.shoot_bullet(bullet_scene, sprite.end_point.global_position, player.get_global_mouse_position(), 1, atk)
	player.audio_player.set_stream(GameManager.bullet_2_sfx)
	player.audio_player.play()
