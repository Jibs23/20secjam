extends State
class_name MoveState
@export var move_speed: float = 300

func move(dir:Vector2) -> void:
	actor.linear_velocity = dir * move_speed
