extends CanvasLayer

func change_scene(target : String):
	$AnimationPlayer.play("transition")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("transition")
	await $AnimationPlayer.animation_finished

func change_scene_packed(target : PackedScene):
	$AnimationPlayer.play("transition")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("transition")
	await $AnimationPlayer.animation_finished


func quit():
	$AnimationPlayer.play("transition")
	await $AnimationPlayer.animation_finished
	get_tree().quit()
