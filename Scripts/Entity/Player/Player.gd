extends Entity

class_name Player

@export var AimRayCast : RayCast2D
@export var energy : Energy
@export var torch : Torch
@export var weapon : Node2D

var dash_bool : bool = false

var inventory : Array[Weapon]
var inventory_slot : int = 0

var ability_list : Array[Ability]
var ability_select : int = 0

func add_weapon(new_weapon : Weapon): 
	inventory.push_back(new_weapon)

func change_slot(delta : int):
	inventory_slot += delta
	inventory_slot = inventory_slot % inventory.size()

func get_current_weapon() -> Weapon:
	if inventory.size() <= inventory_slot:
		return null

	return inventory[inventory_slot]

func add_ability(new_ability : Ability): 
	ability_list.push_back(new_ability)

func change_ability(delta : int):
	ability_select += delta
	ability_select = ability_select % ability_list.size()

func get_current_ability() -> Ability:
	if ability_list.size() <= ability_select:
		return null
	
	return ability_list[ability_select]

func _ready():
	GameManager.player = self
	
	# unlock all abilities
	add_ability(EmSmallen.new())
	add_ability(Maximize.new())
	add_ability(Minimize.new())
	add_ability(Dash_ability.new())
	
	add_weapon(Pistol.new())
	add_weapon(Shotgun.new())
	
	super._ready()

func _physics_process(delta):
	AimRayCast.target_position = get_global_mouse_position() - global_position
	
	super._physics_process(delta)

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		GameManager.player = null
