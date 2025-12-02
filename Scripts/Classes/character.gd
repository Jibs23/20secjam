@icon("res://Assets/Editor Icons/icon_character2d.png")
## Used for 2D characters.
class_name Character2D extends RigidBody2D

@export var health_component: HealthComponent 
@export var state_machine: StateMachine
var screen_check: VisibleOnScreenNotifier2D
## The last emitted direction, to account for Vector2.ZERO deadzone.
var last_dir: Vector2 = Vector2.ZERO

signal input_dir(direction: Vector2)
signal action_1(input: bool)
signal action_2(input: bool)
signal hit(damage: int, from: Node)

## The currently active state instance.
var current_state: State:
	get:
		if state_machine:
			return state_machine.current_state
		return null


func die() -> void:
	print(name, " has died.")
	queue_free()

## Signals the direction input, and accounts for Vector2.ZERO deadzone.
func signal_dir(dir: Vector2) -> void:
	if last_dir == dir and dir == Vector2.ZERO:
		return
	last_dir = dir
	input_dir.emit(dir)

func _ready() -> void:
	screen_check = VisibleOnScreenNotifier2D.new()
	add_child(screen_check)
	screen_check.connect("screen_exited", Callable(self, "_on_screen_exited"))

func _on_screen_exited() -> void:
	push_warning("%s has exited the screen and will be removed." % name)
	die()