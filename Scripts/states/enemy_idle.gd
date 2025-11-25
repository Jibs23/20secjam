extends IdleState


func physics_update(_delta: float) -> void:
	if actor.manager.player_position() != Vector2.ZERO:
		transition.emit(move_state, self)