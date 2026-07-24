extends Node3D

var playerHolder: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerHolder = $PlayerHolder
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dice_roll_finished(value: Variant) -> void:
	$Control/ResultLabel.text = str(value)
	pass # Replace with function body.


func _on_throw_pressed() -> void:
	playerHolder._throwDices()
	pass # Replace with function body.


func _on_decrease_pressed() -> void:
	playerHolder._DecreaseDiceThrowAmount()
	pass # Replace with function body.


func _on_increase_pressed() -> void:
	playerHolder._IncreaseDiceThrowAmount()
	pass # Replace with function body.
