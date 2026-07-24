extends Node3D

@export var playerHolder: Node;
@export var enemyHolder: Node;
@export var resultLabel:Label;

@export var dicesLeftLabel: Label;
@export var diceToThrowLabel: Label;

@export var increaseButton: Button;
@export var decreaseButton: Button;
@export var throwButton: Button;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dice_roll_finished(value: Variant) -> void:
	resultLabel.text = str(value)
	pass # Replace with function body.

func _reportThrowResult(value: int):
	resultLabel.text = str(value)
	enemyHolder._decreaseEnemyHealth(value)
	if !_check_fight_status(): # if player do not have any dices,the enemy have no hp and the player have no throws left to throw
		print("End Fight!")
		if enemyHolder.enemyHealth <= 0 && enemyHolder.currentThrowsAllowed > 0:
			print("Player Win!")
			GameManager.postFightWinner ="Player Wins!"
		else:
			print("Enemy win!")
			GameManager.postFightWinner ="Enemy Wins!"
		SceneLoader.load_scene("uid://ctp2lhorcs1lu")
	pass

func _resetThrowResult():
	resultLabel.text = str("")
	pass

func _on_throw_pressed() -> void:
	if _check_fight_status(): # if player have any dices,the enemy have hp and the player still ahve throws left to throw
		playerHolder._throwDices()
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
