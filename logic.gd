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

func _ready() -> void:
	game_state_changed.emit(game_state)

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
var highscore_list: Array[int] = [0,0,0,0,0]

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

signal new_high_score(new_score: int,index: int,label: Label)
func add_high_score(new_score: int) -> void:
	if new_score < highscore_list[highscore_list.size() - 1] or new_score == 0:
		print("Score %d did not beat the lowest score of %d" % [new_score, highscore_list[highscore_list.size() - 1]])
		return
	var score_labels = ui.high_scores_ui.get_child(0).get_child(1).get_children() as Array[Label]
	highscore_list.append(new_score)
	highscore_list.sort()
	highscore_list.reverse()
	if highscore_list.size() > score_labels.size():
		highscore_list.resize(score_labels.size())
	for slot:Label in score_labels:
		var index = slot.get_index()
		slot.text = str(highscore_list[index])
		if highscore_list[index] == new_score:
			new_high_score.emit(new_score, index, slot)
	

# INPUT
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		set_game_state(GameState.READY)
