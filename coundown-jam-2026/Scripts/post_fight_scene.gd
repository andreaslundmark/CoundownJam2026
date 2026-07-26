extends Control

@export var postFightWinnerResult:Label
@export var postGoldEarningResult:Label
@export var postDiceEarningResult:Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	postFightWinnerResult.text = GameManager.postFightWinner
	postGoldEarningResult.text = GameManager.postGoldChange
	postDiceEarningResult.text = str(GameManager.postDiceChange)
	pass # Replace with function body.

func _on_back_to_menu_button_pressed() -> void:
	SceneLoader.load_scene("uid://vk587e8ah278")
	pass # Replace with function body.
