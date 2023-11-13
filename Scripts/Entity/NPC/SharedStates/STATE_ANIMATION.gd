extends State
class_name STATE_ANIMATION

@export var next_state : State
@export var animationPlayer : AnimationPlayer
@export var melee_attack_node : Node2D
@export var animationName : StringName = "attack"

var isAnimationComplete = false

func start():
	if (animationPlayer && animationPlayer.has_animation(animationName)) :
		isAnimationComplete = false
		animationPlayer.play(animationName)	
		if (!animationPlayer.animation_finished.is_connected(_on_animation_finished)):
			animationPlayer.animation_finished.connect(_on_animation_finished)
	else:
		isAnimationComplete = true
	
func end():
	if (animationPlayer && animationPlayer.has_animation(animationName)) :
		if (animationPlayer.animation_finished.is_connected(_on_animation_finished)):
			animationPlayer.animation_finished.disconnect(_on_animation_finished)
	
func physics_process(_delta : float) -> State:
	if (melee_attack_node and GameManager.target):
		melee_attack_node.look_at(GameManager.target.global_position)
		
	if (isAnimationComplete):
		return next_state
	return null

func _on_animation_finished(_anim_name: StringName) :
	isAnimationComplete = true
