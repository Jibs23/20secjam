extends Node

var game:Node
var player: Character2D

signal player_located

func _on_tree_entered() -> void:
	game = get_tree().get_root().get_node("Game")
	player = game.player

func player_position() -> Vector2:
	if player:
		player_located.emit()
		print("Enemy manager detected player at position: ", player.global_position)
		return player.global_position
	return Vector2.ZERO
