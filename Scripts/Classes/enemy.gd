extends Character2D
class_name Enemy2D

var manager: Node

func die():
	print("Enemy has died.")
	queue_free()

func _on_body_entered(body: Node) -> void:
	print("Enemy hagagegaee13541351it by ", body.name)
	var entity = body
	print(entity.name)
	if entity.is_in_group("player"):
		entity.hit.emit(1, self)
		print("Dealt 1 damage to player.")
	else:
		print("No damage dealt, not a player.")

func _on_tree_entered() -> void:
	manager = get_parent()
	manager.connect("player_located", Callable(self, "_on_player_located"))
