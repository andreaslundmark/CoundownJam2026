extends Node

@export var diceAmount: int = 10;
@export var dicesLeftLabel: Label;
@export var diceToThrowLabel: Label;
@export var dicesToThrow = 3;
var max_amount_to_throw = 5;
@export var increaseButton: Button;
@export var decreaseButton: Button;
@export var throwButton: Button;

var dice_throw_result:int = 0;
var dice_throw_result_reported: bool = false;

var diceThrown: bool = false;
var diceSpawner: Node3D;
@export var main: Node3D;

func _ready() -> void:
	diceSpawner = $DiceSpawner
	diceToThrowLabel.text = str(dicesToThrow)
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
	if !diceThrown && diceSpawner.instnciatedDiceArray.size() > 0:
		for i in range(diceSpawner.instnciatedDiceArray.size()):
			dice_throw_result += diceSpawner.instnciatedDiceArray[i].diceFaceSelected.integerValue
		if !dice_throw_result_reported:
			main._reportThrowResult(dice_throw_result)
			dice_throw_result_reported = true
	pass

func _DecreaseDiceAmount(value: int = 1):
	diceAmount -= value;
	dicesLeftLabel.text = str(diceAmount);
	
func _IncreaseDiceThrowAmount():
	if dicesToThrow < diceAmount && dicesToThrow < max_amount_to_throw:
		dicesToThrow += 1;
	else:
		#print("Can not increase more!")
		pass
	diceToThrowLabel.text = str(dicesToThrow)
	
func _DecreaseDiceThrowAmount():
	if dicesToThrow > 1:
		dicesToThrow -= 1;
	else:
		#print("Can not decrease more!")
		pass
	diceToThrowLabel.text = str(dicesToThrow)

func _throwDices():
	if diceAmount > 0 && !diceThrown:
		dice_throw_result_reported = false
		_clearInstanciatedDices()
		main._resetThrowResult()
		dice_throw_result = 0
		diceThrown = true;
		for i in range(dicesToThrow):
			var new_scene = diceSpawner.scene_to_instantiate.instantiate()
			add_child(new_scene)
			diceSpawner.instnciatedDiceArray.append(new_scene)
			_DecreaseDiceAmount();
		if dicesToThrow > diceAmount:
			diceToThrowLabel.text = str(diceAmount)
			dicesToThrow = diceAmount
	pass

func _clearInstanciatedDices():
	for i in range(diceSpawner.instnciatedDiceArray.size()):
		diceSpawner.instnciatedDiceArray[i]. queue_free()
		
	diceSpawner.instnciatedDiceArray.clear()
