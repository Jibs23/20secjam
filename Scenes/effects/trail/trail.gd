class_name Trail
extends Line2D

@export var trail_lenght: int = 10
@onready var curve: Curve2D = Curve2D.new()
@export var relative_parent: Node2D = self

func _ready() -> void:
	position = Vector2.ZERO
	start_trail()

func _process(_delta: float) -> void:
	curve.add_point(relative_parent.global_position - global_position)
	if curve.get_baked_points().size() > trail_lenght:
		curve.remove_point(0)
	points = curve.get_baked_points()

func stop() -> void:
	var tw := get_tree().create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 3.0)
	await tw.finished
	queue_free()

func start_trail() -> Trail:
	var trail = preload("res://Scenes/effects/trail/trail.tscn")
	return trail.instantiate()
