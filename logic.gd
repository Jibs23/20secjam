extends Node

var game:Node
var player: Character2D
var enemy_manager: Node2D
var ui: Node
var audio_manager: Node

# GAME STATE MANAGEMENT
enum GameState {
	PLAYING,
	GAMEOVER,
	READY
}

signal game_state_changed(new_state: GameState)
var game_state: GameState = GameState.READY

func set_game_state(new_state: GameState) -> void:
	match new_state:
		GameState.PLAYING:
			start_game()
		GameState.GAMEOVER:
			game_over()
		GameState.READY:
			restart_game()

func restart_game() -> void:
	game_state = GameState.READY
	game_state_changed.emit(game_state)
	get_tree().reload_current_scene()

func start_game() -> void:
	game_state = GameState.PLAYING
	reset_score()
	enemy_manager.toggle_enemy_spawn(true)
	game_state_changed.emit(game_state)

func game_over() -> void:
	game_state = GameState.GAMEOVER
	enemy_manager.toggle_enemy_spawn(false)
	add_high_score(score)
	game_state_changed.emit(game_state)

func _on_player_wake() -> void:
	if player.sleeping == false:
		set_game_state(GameState.PLAYING)
		print("Player woke up, resuming game.")

# SCORE TRACKING
var score: int = 0
var high_score: Array[int] = []
var high_score_list_size: int = 5

const SCORE_POP: PackedScene = preload("res://Scenes/effects/score_pop.tscn")
func add_score(points: int,popup:Vector2=Vector2.ZERO) -> void:
	score += points
	if popup != Vector2.ZERO:
		var popup_instance: Label = SCORE_POP.instantiate()
		ui.add_child(popup_instance)
		popup_instance.global_position = popup
		popup_instance.text = str(points)

func reset_score() -> void:
	score = 0

func add_high_score(new_score: int) -> void:
	high_score.append(new_score)
	high_score.sort()
	high_score.reverse()
	if high_score.size() > high_score_list_size:
		high_score.resize(high_score_list_size)
	

# INPUT
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		set_game_state(GameState.READY)
