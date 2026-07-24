extends Node

@export var diceAmount: int = 10;
@export var dicesLeftLabel: Label;
@export var diceToThrow: Label;
@export var dicesToThrow = 3;
@export var increaseButton: Button;
@export var decreaseButton: Button;
@export var throwButton: Button;

var diceThrown: bool = false;
var diceSpawner: Node3D;

func _ready() -> void:
	diceSpawner = $DiceSpawner
	diceToThrow = $"../Control/Label3"
	diceToThrow.text = str(dicesToThrow)
	dicesLeftLabel.text = str(diceAmount);
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if diceThrown:
		for i in range(diceSpawner.instnciatedDiceArray.size()):
			if diceSpawner.instnciatedDiceArray[i].is_rolling:
				break
			elif i >= (diceSpawner.instnciatedDiceArray.size()-1): #if the for loop got to the end without any dice is rolling then the throw is done
				print("throw done")
				diceThrown = false	
	pass

func _DecreaseDiceAmount():
	diceAmount -= 1;
	dicesLeftLabel.text = str(diceAmount);
	
func _IncreaseDiceThrowAmount():
	dicesToThrow += 1;
	diceToThrow.text = str(dicesToThrow)
	
func _DecreaseDiceThrowAmount():
	dicesToThrow -= 1;
	diceToThrow.text = str(dicesToThrow)

func _throwDices():
	if diceAmount > 0 && !diceThrown:
		diceThrown = true;
		for i in range(dicesToThrow):
			var new_scene = diceSpawner.scene_to_instantiate.instantiate()
			add_child(new_scene)
			diceSpawner.instnciatedDiceArray.append(new_scene)
			_DecreaseDiceAmount();
	pass
