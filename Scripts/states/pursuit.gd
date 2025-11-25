extends MoveState

var target_pos: Vector2 = Vector2.ZERO

func physics_update(_delta: float) -> void:
	target_pos = get_target()
	var dir: Vector2 = (target_pos - actor.global_position).normalized()
	move(dir)

func get_target() -> Vector2:
	var go_to: Vector2 = Vector2.ZERO
	if actor.manager.player_position() != Vector2.ZERO:
		go_to = actor.manager.player_position()
	else: 
		print("No player position found.")
		transition.emit(state_idle, self)

	return go_to
