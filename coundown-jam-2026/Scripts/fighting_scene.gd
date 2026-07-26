extends Node3D

@export var playerHolder: Node;
@export var enemyHolder: Node;
@export var resultLabel:Label;

@export var dicesLeftLabel: Label;
@export var diceToThrowLabel: Label;

@export var increaseButton: Button;
@export var decreaseButton: Button;
@export var throwButton: Button;

@export var enemyEffectText1: RichTextLabel;
@export var enemyEffectText2: RichTextLabel;
@export var enemyEffectText3: RichTextLabel;
@export var enemyEffectText4: RichTextLabel;

var resultReported: bool = false

func _ready() -> void:
	GameManager.postGoldChange = ""
	dicesLeftLabel.text = str(SaveLoadManager.save_data.diceAmount)
		

func _on_dice_roll_finished(value: Variant) -> void:
	resultLabel.text = str(value)
	pass # Replace with function body.

func _reportThrowResult(value: int) -> void:
	if !resultReported:
		resultLabel.text = str(value)
		_check_enemy_effects(value)
		enemyHolder._decreaseEnemyHealth(value)
		if !_check_fight_status(): # if player do not have any dices,the enemy have no hp and the player have no throws left to throw
			print("End Fight!")
			if enemyHolder.enemyHealth <= 0 && enemyHolder.currentThrowsAllowed > 0:
				print("Player Win!")
				GameManager.postFightWinner ="Player Wins!"
				SaveLoadManager.save_data.playerGold += 50
				SaveLoadManager.save_data.diceAmount = (playerHolder.diceAmount+8)
				SaveLoadManager._saveGame()
				GameManager.postGoldChange = "+50"
				GameManager.postDiceChange = "+"+str(playerHolder.diceAmount+8)
				print(SaveLoadManager.save_data.playerGold)
			else:
				print("Enemy win!")
				GameManager.postFightWinner ="Enemy Wins!"
				SaveLoadManager.save_data.playerGold -= 10
				SaveLoadManager.save_data.diceAmount = (playerHolder.diceAmount+5)
				SaveLoadManager._saveGame()
				GameManager.postGoldChange = "-10"
				GameManager.postDiceChange = "+"+str(playerHolder.diceAmount+5)
				print(SaveLoadManager.save_data.playerGold)
			SceneLoader.load_scene("uid://ctp2lhorcs1lu")
			resultReported = true
	pass

func _resetThrowResult() -> void:
	resultLabel.text = str("")
	pass

func _on_throw_pressed() -> void:
	if _check_fight_status(): # if player have any dices,the enemy have hp and the player still ahve throws left to throw
		playerHolder._throwDices()
		enemyEffectText1.visible = true;
		enemyEffectText2.visible = true;
		enemyEffectText3.visible = true;
		enemyEffectText4.visible = true;
	pass # Replace with function body.


func _on_decrease_pressed() -> void:
	playerHolder._DecreaseDiceThrowAmount()
	pass # Replace with function body.


func _on_increase_pressed() -> void:
	playerHolder._IncreaseDiceThrowAmount()
	pass # Replace with function body.


func _check_fight_status() -> bool:
	if  playerHolder.diceAmount > 0 && enemyHolder.enemyHealth > 0 && enemyHolder.currentThrowsAllowed > 0: 
		return true
	return false
	
func _check_enemy_effects(value: int) -> void:
	if value >= 10 && value <=15:
		playerHolder._DecreaseDiceAmount(1)
		enemyEffectText1.visible = true;
		enemyEffectText2.visible = false;
		enemyEffectText3.visible = false;
		enemyEffectText4.visible = false;
	elif value == 6:
		playerHolder._IncreaseDiceAmount(5)
		enemyEffectText1.visible = false;
		enemyEffectText2.visible = true;
		enemyEffectText3.visible = false;
		enemyEffectText4.visible = false;
	elif value == 1:
		playerHolder._DecreaseDiceAmount(playerHolder.diceAmount/2)
		enemyEffectText1.visible = false;
		enemyEffectText2.visible = false;
		enemyEffectText3.visible = true;
		enemyEffectText4.visible = false;
	elif value == 2 && playerHolder.dicesToThrow == 1 || value == 3 && playerHolder.dicesToThrow == 1:
		playerHolder._IncreaseDiceAmount(3)
		enemyEffectText1.visible = false;
		enemyEffectText2.visible = false;
		enemyEffectText3.visible = false;
		enemyEffectText4.visible = true;
	pass
