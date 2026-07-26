extends Node

var postFightWinner: String = "Player?"
var postGoldChange: String;
var postDiceChange: String;

var goldToObtainForWin: int = 100

func _check_if_player_reched_end(diceAmount: int, goldAmount: int, PlayerWinLossLabel: Label = null, PlayerWinLossText: RichTextLabel = null, node: Control = null) -> void:
	if goldAmount >= goldToObtainForWin:
		node.visible = true
		print("Player won the game!")
		PlayerWinLossLabel.text = "Player won the game!"
		PlayerWinLossText.text = "You gained enought gold an won. Reset the savefile to play again."
	elif diceAmount <= 0:
		node.visible = true
		print("Player lost the game!")
		PlayerWinLossLabel.text = "Player lost the game!"
		PlayerWinLossText.text = "You lost the game. Reset the savefile to play again."
	
