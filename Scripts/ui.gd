extends CanvasLayer

signal time_limit_timeout
@export var timer: Timer
@export var game_ui: Control
@export var score_label: Label
@export var high_scores: Control

func _init() -> void:
	Logic.ui = self
	Logic.connect("game_state_changed", Callable(self, "_on_game_state_changed"))
	
	
func _ready() -> void:
	score_label.target_node = Logic

func _on_time_limit_timeout() -> void:
	time_limit_timeout.emit()
	Logic.set_game_state(Logic.GameState.GAMEOVER)

func pause_timer() -> void:
	timer.pause()

func toggle_menu_visibility(visibility: bool) -> void:
	high_scores.visible = visibility

func toggle_game_ui_visibility(visibility: bool) -> void:
	game_ui.visible = visibility

func _on_game_state_changed(new_state: Logic.GameState) -> void:
	match new_state:
		Logic.GameState.PLAYING:
			timer.start()
			toggle_menu_visibility(false)
			toggle_game_ui_visibility(true)
		Logic.GameState.GAMEOVER:
			timer.stop()
			toggle_menu_visibility(true)
			toggle_game_ui_visibility(false)
		Logic.GameState.READY:
			timer.stop()
