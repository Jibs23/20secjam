extends Resource
class_name ResourceEnemy

@export var enemy_name: String = "Enemy"
@export var health: int = 1
@export var max_speed: float = 500.0
@export var acceleration: float = 400.0
@export var damage: int = 1
@export var score_value: int = 10
## The higher the weight, the more likely this enemy is to spawn. Scale from 0 to 100
@export var spawn_weight: float = 50
@export var scene: PackedScene
## In percentage
@export var max_count: float = 0 # 0 means unlimited
var enemy_count: int = 0
@export var enemy_group: String = "enemy_"