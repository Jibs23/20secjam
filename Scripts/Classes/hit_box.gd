@icon("res://Assets/Editor Icons/icon_square_hitbox.png")
## Area at which an entity can be hit.
class_name HitShape2D extends CollisionShape2D

signal hit(damage: int, from: Node)

