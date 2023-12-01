extends TextureRect

var torch : Torch
@export var graphics : Array[CompressedTexture2D]
@export var graphics_desel : Array[CompressedTexture2D]

func _ready():
	if GameManager.player:
		torch = GameManager.player.torch

func _process(_delta):
	if GameManager.player:
		var level : int = roundi(torch.power / torch.power_max * (graphics.size() - 1))
	
		texture = graphics_desel[level]
