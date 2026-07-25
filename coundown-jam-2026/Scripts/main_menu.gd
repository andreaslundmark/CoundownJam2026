extends Control

@export var initial_scene: StringName = &""
@export var currentGold: Label;
@export var currentDiceAmount: Label;

func _ready() -> void:
	currentGold.text = str(SaveLoadManager.save_data.playerGold)
	currentDiceAmount.text = str(SaveLoadManager.save_data.diceAmount)

func _on_start_game_pressed() -> void:
	SceneLoader.load_scene(initial_scene)
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	SaveLoadManager.save_data = SaveLoadManager.reset_save_data
	SaveLoadManager._saveGame()
	SaveLoadManager._loadGame()
	currentGold.text = str(SaveLoadManager.save_data.playerGold)
	currentDiceAmount.text = str(SaveLoadManager.save_data.diceAmount)
	pass # Replace with function body.
