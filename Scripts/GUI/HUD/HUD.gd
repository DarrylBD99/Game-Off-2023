extends Control

func hide_hud():
	$AnimationPlayer.play("hide_hud")
	
func show_hud():
	$AnimationPlayer.play_backwards("hide_hud")
