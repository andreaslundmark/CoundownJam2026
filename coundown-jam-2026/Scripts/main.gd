extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dice_roll_finished(value: Variant) -> void:
	$Control/ResultLabel.text = str(value)
	pass # Replace with function body.
