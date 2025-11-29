extends Node2D

@onready var timer: Timer = $Timer

signal spawn_indicator_finished()

func _on_timer_timeout() -> void:
	spawn_indicator_finished.emit()
	queue_free()