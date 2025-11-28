@icon("res://Assets/Editor Icons/icon_sword.png")
extends RigidBody2D
class_name PhysicsWeapon



var last_angular_velocity: float

func _physics_process(_delta: float) -> void:
	last_angular_velocity = angular_velocity

func wpn_action_1(held:bool):
	pass

func wpn_action_2(held:bool):
	pass

	
func start_cooldown(time:float) -> Timer:
	var timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = true
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_cooldown_timeout"))
	timer.connect("timeout", Callable(timer, "queue_free"))
	add_child(timer)
	return timer

var player:Character2D

func _enter_tree() -> void:
	if !get_parent().is_in_group("player"): 
		push_error(self.name + " assigned wrong parent")
		return
	player = get_parent() 
	player.weapon = self
	player.connect("action_1", Callable(self,"wpn_action_1"))
	player.connect("action_2", Callable(self,"wpn_action_2"))
	print(self.name," set as player weapon.")

var swing_cooldown_timer: Timer
@export_category("Weapon Damage")
@export_range(1, 10, 1) var weapon_dmg: int = 1
@export_range(0.1, 800, 0.1,"radians_as_degrees") var max_dmg_speed: float = 8.72
@export_range(0.1, 800, 0.1,"radians_as_degrees") var min_dmg_speed: float = 4.364
@export var dmg_threshold: Curve = Curve.new()

func calc_dammage() -> int:
	var output: int = 0
	if abs(last_angular_velocity) < min_dmg_speed:
		output = 0
		print("too slow: no damage dealt.")
	elif abs(last_angular_velocity) >= max_dmg_speed:
		output = int(dmg_threshold.sample(1.0) * weapon_dmg)
		print("Max damage dealt!!")
	else:
		var dmg_mult: float = abs(last_angular_velocity) / max_dmg_speed # get percentage of max_dmg_speed
		var dmg_sample: float = dmg_threshold.sample(dmg_mult) # sample curve at that percentage
		output = int(roundf(dmg_sample) * weapon_dmg) # scale by weapon damage
		print("Damage scaled with speed.")

	print("Calculated damage: %s with %f" % [str(output), rad_to_deg(abs(last_angular_velocity))])
	return output

func _on_body_entered(body: Node2D) -> void:
	var calc_dmg: int = calc_dammage()
	if calc_dmg <= 0: return
	if body.has_signal("hit"):
		body.emit_signal("hit", calc_dmg, self)
	else:
		print(body.name, " has no 'hit' signal to deal damage to.")
	
