extends Node
class_name CustomMotion

@export var curve : Curve 
@export var distance : float 
@export var time : float 

var timer : float
var isPlaying : bool
var direction : Vector2
var character : CharacterBody2D

func play(new_character:CharacterBody2D, new_direction: Vector2):
	timer = 0
	isPlaying = true
	direction = new_direction
	character = new_character
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func manual_process(delta):
	if (!isPlaying) :
		return;
	
	if (!character):
		return

	var a_normalized_time = timer / time
	
	timer = min(timer + delta, time)
	var b_normalized_time = timer / time
	
	var a_value = curve.sample(a_normalized_time)
	var b_value = curve.sample(b_normalized_time)
	var delta_move = (b_value - a_value) * distance
	
	character.velocity = direction * (delta_move / delta)
	character.move_and_slide()
	
	isPlaying = time > timer
