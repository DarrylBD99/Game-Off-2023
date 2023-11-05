extends State
class_name SizeState

@export var speed_multiplier : float = 1
@export var health_multiplier : float = 1
@export var attack_multiplier : float = 1
@export var size_multiplier : float = 1
@export var timer : Timer

var speed_origin : float
var scale_origin : Vector2

func state_ready():
	speed_origin = entity.speed
	scale_origin = entity.scale

func start():
	timer.start()
	
	if entity.health:
		entity.health.hp = entity.health.hp * health_multiplier
		entity.health.hp_max = entity.health.hp_max * health_multiplier
	
	if entity.attack:
		entity.attack.atk = entity.attack.atk * attack_multiplier

func physics_process(_delta : float) -> State:
	if not timer.is_stopped():
		var time_elapsed : float = timer.wait_time - timer.time_left
		var time_elapsed_percent : float = time_elapsed / timer.wait_time
		
		entity.speed += ((speed_origin * speed_multiplier) - entity.speed) * time_elapsed_percent
		entity.scale += ((scale_origin * size_multiplier) - entity.scale) * time_elapsed_percent
	else:
		entity.speed = speed_origin * speed_multiplier
		entity.scale = scale_origin * size_multiplier
	
	return null

func end():
	if entity.health:
		entity.health.hp = entity.health.hp / health_multiplier
		entity.health.hp_max = entity.health.hp_max / health_multiplier
	
	if entity.attack:
		entity.attack.atk = entity.attack.atk / attack_multiplier
