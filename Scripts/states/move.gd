extends State
class_name MoveState
@export_range(0, 2000) var max_move_speed: float = 500
@export_range(0, 3000) var acceleration: float = 400
var speed: float:
	get:
		return actor.linear_velocity.length()
var moving_dir: Vector2:
	get:
		return actor.linear_velocity.normalized()

@export var weapon: PhysicsWeapon

func move(dir:Vector2) -> void:
	if dir == Vector2.ZERO: return
	if speed >= max_move_speed and dir.dot(moving_dir) > 0: return
	actor.apply_central_force(Vector2(dir * acceleration))
