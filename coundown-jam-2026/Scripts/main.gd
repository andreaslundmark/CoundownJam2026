extends Node3D

@export var playerHolder: Node;
@export var resultLabel:Label;

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
	pass

func _resetThrowResult():
	resultLabel.text = str("")
	pass

func _on_throw_pressed() -> void:
	playerHolder._throwDices()
	pass # Replace with function body.


func _on_decrease_pressed() -> void:
	playerHolder._DecreaseDiceThrowAmount()
	pass # Replace with function body.


func _on_increase_pressed() -> void:
	playerHolder._IncreaseDiceThrowAmount()
	pass # Replace with function body.
