extends Label

@export var speed_curve:Curve = Curve.new()
@export var size_curve: Curve = Curve.new()
@export var timer:Timer

func _process(_delta: float) -> void:
	if timer.time_left <= 0:
		queue_free()
	position += speed_curve.sample(timer.time_left/timer.wait_time) * Vector2.UP
	scale = Vector2.ONE * size_curve.sample(timer.time_left/timer.wait_time)
