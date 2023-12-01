extends Resource
class_name SaveData

@export var level : int = 1

@export var weapon_slot : int = 0
@export var ability_slot : int = 0
@export var game_beaten : bool = false

func get_level() -> int:
	return level

func get_weapon_slot() -> int:
	return weapon_slot

func get_ability_slot() -> int:
	return ability_slot

func get_beaten_bool() -> bool:
	return game_beaten


func set_level(level : int):
	self.level = level

func set_weapon_slot(weapon_slot : int):
	self.weapon_slot = weapon_slot

func set_ability_slot(ability_slot : int):
	self.ability_slot = ability_slot

func set_beaten_bool(game_beaten : bool):
	self.game_beaten = game_beaten
