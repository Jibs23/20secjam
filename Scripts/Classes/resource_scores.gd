@tool
extends Resource

@export var highscore_list: Array[int] = [0,0,0,0,0]


@export_category("Highscore Management")
@export_tool_button("erase","Erase") var erase_button: Callable = erase
@export_tool_button("save","Save") var save_button: Callable = save
@export_tool_button("load","Load") var load_button: Callable = load

func erase() -> void:
	highscore_list = [0,0,0,0,0]
	save()

func save() -> void:
	var file: FileAccess = FileAccess.open("user://highscores.save", FileAccess.WRITE)
	if file:
		file.store_var(highscore_list)
		file.flush() # Ensure data is written to disk
		file.close()
		print("Saved highscores: ", highscore_list)
	else:
		print("Failed to save highscores - could not open file for writing")
	
func load() -> Resource:
	if FileAccess.file_exists("user://highscores.save"):
		var file: FileAccess = FileAccess.open("user://highscores.save", FileAccess.READ)
		if file:
			var loaded_data = file.get_var()
			if loaded_data != null and loaded_data is Array:
				highscore_list = loaded_data
				print("Loaded highscores: ", highscore_list)
			file.close()
		else:
			print("Failed to open highscores save file")
	else:
		print("No save file found, using default highscores")
	return self
