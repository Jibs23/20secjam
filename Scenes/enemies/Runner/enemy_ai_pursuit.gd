extends Enemy2D

func _on_player_located() -> void:
	input_dir.emit(Vector2.LEFT)
	print("Player located by enemy pursuit AI.")
	# Transition to move state or take appropriate action

