extends Control

@export var initial_scene: StringName = &""
@export var currentGold: Label;
@export var currentDiceAmount: Label;
@export var goalLabelText: Label;
@export var playerWinLossLabel: Label;
@export var playerWinLossText: RichTextLabel;

func _ready() -> void:
	$WinLossPopup.visible = false
	GameManager._check_if_player_reched_end(SaveLoadManager.save_data.diceAmount,SaveLoadManager.save_data.playerGold,playerWinLossLabel,playerWinLossText,$WinLossPopup)
	currentGold.text = str(SaveLoadManager.save_data.playerGold)
	currentDiceAmount.text = str(SaveLoadManager.save_data.diceAmount)
	goalLabelText.text = "Gain " +  str(GameManager.goldToObtainForWin) +  " gold to win the game, 
loosing all the dices will result in a game over."

func _on_start_game_pressed() -> void:
	$WinLossPopup.visible = false
	SceneLoader.load_scene(initial_scene)
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	$WinLossPopup.visible = false
	SaveLoadManager.save_data = SaveLoadManager.reset_save_data
	SaveLoadManager._saveGame()
	SaveLoadManager._loadGame()
	currentGold.text = str(SaveLoadManager.save_data.playerGold)
	currentDiceAmount.text = str(SaveLoadManager.save_data.diceAmount)
	pass # Replace with function body.
