extends TextureProgressBar

@export var health : Health

var old_value : float
var hp : float
var max_hp : float
var visible_bool : bool = false
var fade_bool : bool = false

func _ready():
	max_hp = health.hp_max
	hp = health.hp
	old_value = hp / max_hp * max_value
	value = hp
	
	set_modulate(Color(1,1,1,0))

func _process(_delta):
	max_hp = health.hp_max
	hp = health.hp
	
	value = hp / max_hp * max_value
	
	if visible_bool and $VisibleTimer.is_stopped():
		visible_bool = false
		fade_bool = true
		$FadeTimer.start()
	
	if fade_bool:
		if not $FadeTimer.is_stopped():
			var time_elapsed : float = $FadeTimer.wait_time - $FadeTimer.time_left
			var time_elapsed_fraction : float = time_elapsed / $FadeTimer.wait_time
			
			var opacity : float = 1 - time_elapsed_fraction
			set_modulate(Color(1,1,1,opacity))
		else:
			set_modulate(Color(1,1,1,0))
			fade_bool = false
	
	if not old_value == value:
		$VisibleTimer.stop()
		$FadeTimer.stop()
		
		set_modulate(Color(1,1,1,1))
		old_value = value
		fade_bool = false
		visible_bool = true
		$VisibleTimer.start()
