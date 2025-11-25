extends Component

@export var dmg: int = 1:
	get:
		return get_parent().dmg

## Handles hit detection and damage application.
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	var collied_shape = body.get_child(body.get_index(body_shape_index))
	print("Weapon hit ", body.name, " on shape ", str(collied_shape))
	if collied_shape is HitShape2D:
		if dmg <= 0:
			print("No damage to deal.")
			return
		var hitbox: HitShape2D = collied_shape
		hitbox.hit.emit(dmg, self)
		print("Dealt ", dmg, " damage to ", body.name)