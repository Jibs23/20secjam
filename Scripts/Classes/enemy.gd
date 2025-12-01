@icon("res://Assets/Editor Icons/icon_character2d_enemy.png")
extends Character2D
class_name Enemy2D

var manager: Node2D
@export var bounce_force: float = 400.0
signal enemy_dead(enemy:Enemy2D)
signal touched_player(enemy:Enemy2D)

func die():
	enemy_dead.emit(self)
	print("%s has died." % name)
	queue_free()


func _on_body_entered(body: Node) -> void:
	var entity = body
	if entity.is_in_group("player"):
		entity.hit.emit(1, self)
		var dir:Vector2 = (self.global_position - entity.global_position).normalized()
		apply_central_impulse(dir * bounce_force)
		touched_player.emit(self)
		print("Dealt 1 damage to player.")

func _on_tree_entered() -> void:
	manager = get_parent()
	connect("enemy_dead", Callable(manager, "_on_enemy_dead"))
