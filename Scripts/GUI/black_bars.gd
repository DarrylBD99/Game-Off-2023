extends Control

func show_bars():
	$AnimationPlayer.play("show_bars")

func hide_bars():
	$AnimationPlayer.play_backwards("show_bars")
	
