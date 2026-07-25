extends Node3D

@export var playerHolder: Node;
@export var enemyHolder: Node; #Not used in most events
@export var resultLabel:Label;

@export var dicesLeftLabel: Label;
@export var diceToThrowLabel: Label;

@export var increaseButton: Button;
@export var decreaseButton: Button;
@export var throwButton: Button;

var resultReported: bool = false

@export var effect1: RichTextLabel;
@export var effect2: RichTextLabel;
@export var effect3: RichTextLabel;

func _ready() -> void:
		dicesLeftLabel.text = str(SaveLoadManager.save_data.diceAmount)

func _on_dice_roll_finished(value: Variant) -> void:
	resultLabel.text = str(value)
	pass # Replace with function body.

func _reportThrowResult(value: int) -> void:
	if !resultReported:
		resultLabel.text = str(value)
		 # hardcoded events for now switch out for modifiable event if i have time
		if value <= 2:
			print("dread")
			effect2.visible = false
			effect3.visible = false
			SaveLoadManager.save_data.diceAmount = (playerHolder.diceAmount-3)
			SaveLoadManager._saveGame()
			playerHolder.diceAmount =SaveLoadManager.save_data.diceAmount
			dicesLeftLabel.text = str(SaveLoadManager.save_data.diceAmount)
		elif value == 3 || value == 4:
			print("numb")
			effect1.visible = false
			effect3.visible = false
			pass
		elif value == 5 || value == 6:
			print("hope")
			effect1.visible = false
			effect2.visible = false
			SaveLoadManager.save_data.diceAmount = (playerHolder.diceAmount+3)
			SaveLoadManager._saveGame()
			playerHolder.diceAmount =SaveLoadManager.save_data.diceAmount
			dicesLeftLabel.text = str(SaveLoadManager.save_data.diceAmount)
		resultReported = true

func _resetThrowResult() -> void:
	resultLabel.text = str("")
	pass

func _on_throw_pressed() -> void:
	if _check_event_status(): # if player have any dices,the enemy have hp and the player still ahve throws left to throw
		diceToThrowLabel.visible = false
		throwButton.visible = false
		$Control/PlayerUI/PlayerBotContainer/DiceToThrowLabel.visible = false
		playerHolder._throwDices()
	pass # Replace with function body.


func _on_decrease_pressed() -> void:
	playerHolder._DecreaseDiceThrowAmount()
	pass # Replace with function body.


func _on_increase_pressed() -> void:
	playerHolder._IncreaseDiceThrowAmount()
	pass # Replace with function body.
	
func _check_event_status() -> bool:
	if  playerHolder.diceAmount > 0: 
		return true
	return false


func _on_enter_dungeon_button_pressed() -> void:
	SceneLoader.load_scene("uid://b68re1mio21kt")
	pass # Replace with function body.
	
