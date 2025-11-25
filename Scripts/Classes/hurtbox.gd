@tool
@icon("res://Assets/Editor Icons/icon_square_hurtbox.png")
## area that can deal damage to entities with HitShapes.
class_name HurtShape2D extends CollisionShape2D
@export var damage: int = 1
@export var auto_hit: bool = true
