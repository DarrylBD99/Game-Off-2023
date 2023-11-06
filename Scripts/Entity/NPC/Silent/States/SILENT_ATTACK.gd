extends State

@export var move : State
@export var animationPlayer : AnimationPlayer

var isAnimationComplete = false
var animationName = "attack"

func start():
	if (animationPlayer && animationPlayer.has_animation(animationName)) :
		isAnimationComplete = false
		animationPlayer.play(animationName)	
		animationPlayer.animation_finished.connect(_on_animation_finished)
	else:
		isAnimationComplete = true
	
func end():
	if (animationPlayer && animationPlayer.has_animation(animationName)) :
		animationPlayer.animation_finished.disconnect(_on_animation_finished)
	
func physics_process(_delta : float) -> State:
	if (isAnimationComplete):
		return move
	return null

func _on_animation_finished(_anim_name: StringName) :
	isAnimationComplete = true
