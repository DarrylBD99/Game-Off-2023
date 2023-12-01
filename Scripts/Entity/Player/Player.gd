extends Entity

class_name Player

@export var AimRayCast : RayCast2D
@export var energy : Energy
@export var torch : Torch
@export var weapon_pos : Node2D

var dash_bool : bool = false

var inventory : Array[Weapon]

var ability_list : Array[Ability]

func add_weapon(new_weapon : Weapon): 
	inventory.push_back(new_weapon)

func change_slot(delta : int):
	GameManager.weapon_slot += delta
	GameManager.weapon_slot = GameManager.weapon_slot % inventory.size()

func get_current_weapon() -> Weapon:
	if inventory.size() <= GameManager.weapon_slot:
		return null

	return inventory[GameManager.weapon_slot]

func add_ability(new_ability : Ability): 
	ability_list.push_back(new_ability)

func change_ability(delta : int):
	GameManager.ability_slot += delta
	GameManager.ability_slot = GameManager.ability_slot % ability_list.size()

func get_current_ability() -> Ability:
	if ability_list.size() <= GameManager.ability_slot:
		return null
	
	return ability_list[GameManager.ability_slot]

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

func move_sprite():
	animation_tree.set("parameters/Movement/blend_position", 1)

func idle_sprite():
	animation_tree.set("parameters/Movement/blend_position", 0)
