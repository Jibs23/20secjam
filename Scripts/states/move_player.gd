## Move the actor in the given input direction.
extends MoveState

## Used in _physics_process, to be called every physics frame.
func physics_update(_delta: float) -> void:
	if input_dir == Vector2.ZERO:
		transition.emit(state_idle)
	move(input_dir)

