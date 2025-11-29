extends IdleState

@export var stunned:Timer

func physics_update(_delta: float) -> void:
	if stunned: return
	if actor.manager.player_position() != Vector2.ZERO:
		transition.emit(move_state, self)