extends Node2D
class_name SilentFootstep

@export var animationPlayer : AnimationPlayer

func play():
	animationPlayer.play("footstep_fade")
	animationPlayer.animation_finished.connect(on_animation_finished)

func on_animation_finished(_anim_name: StringName):
	queue_free()
