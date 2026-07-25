extends Node
#initial variation of script found here https://www.youtube.com/watch?v=Dw45NlwIORY

var scriptName: String = "SaveLoadManager: "
const FILE_PATH: String = "user://CoundownJam2026SaveFile.json" # using user so it is read and write and saved at \Users\<YourUsername>\AppData\Roaming\Godot\app_userdata\<YourProjectName>\

var reset_save_data: Dictionary = {
	"seenTutorial": false,
	"playerGold": 0,
	"diceAmount": 11
}

var save_data: Dictionary = {
	"seenTutorial": false,
	"playerGold": 0,
	"diceAmount": 11
}

func _ready() -> void:
	_loadGame()

func _saveGame() -> void:
	print(scriptName+"trying to save")
	var tempfile: FileAccess = FileAccess.open_encrypted_with_pass(FILE_PATH, FileAccess.WRITE, "s9C*ght!33fgy>llö")
	tempfile.store_var(save_data)
	tempfile.close()
	print(scriptName + "Game Saved")
	pass
	
func _loadGame() -> void:
	print(scriptName+ "trying to load game")
	if FileAccess.file_exists(FILE_PATH):
		var tempfile: FileAccess = FileAccess.open_encrypted_with_pass(FILE_PATH, FileAccess.READ, "s9C*ght!33fgy>llö")
		var data: Dictionary = tempfile.get_var()
		for i in data:
			if save_data.has(i):
				save_data[i] = data[i]
		tempfile.close()
		print(scriptName + "GameLoaded")
	else:
		print("File in FilePath not found!")
		_saveGame()
	pass
