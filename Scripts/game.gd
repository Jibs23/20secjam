extends Node


var player: Character2D
var enemy_manager: Node2D

func _init() -> void:
	Logic.game = self