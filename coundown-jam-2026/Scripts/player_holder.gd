extends Node

var diceAmount: int = 10;
var dicesLeftLabel: Label;
var diceToThrowLabel: Label;
var dicesToThrow = 3;
var maxAmountToThrow = 5;
var increaseButton: Button;
var decreaseButton: Button;
var throwButton: Button;

var diceThrowResult:int = 0;
var diceThrowResultReported: bool = false;

var diceThrown: bool = false;
var diceSpawner: Node3D;
@export var fightingSceneNode: Node3D;

var playerGold = 100;

func _ready() -> void:
	diceSpawner = $DiceSpawner
	dicesLeftLabel = fightingSceneNode.dicesLeftLabel
	diceToThrowLabel = fightingSceneNode.diceToThrowLabel
	increaseButton = fightingSceneNode.increaseButton
	decreaseButton = fightingSceneNode.decreaseButton
	decreaseButton = fightingSceneNode.decreaseButton
	diceToThrowLabel.text = str(dicesToThrow)
	dicesLeftLabel.text = str(diceAmount);
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if diceThrown:
		for i in range(diceSpawner.instnciatedDiceArray.size()):
			if diceSpawner.instnciatedDiceArray[i].isRolling:
				break
			elif i >= (diceSpawner.instnciatedDiceArray.size()-1): #if the for loop got to the end without any dice is rolling then the throw is done
				print("throw done")
				diceThrown = false	
	if !diceThrown && diceSpawner.instnciatedDiceArray.size() > 0:
		for i in range(diceSpawner.instnciatedDiceArray.size()):
			diceThrowResult += diceSpawner.instnciatedDiceArray[i].diceFaceSelected.integerValue
		if !diceThrowResultReported:
			fightingSceneNode._reportThrowResult(diceThrowResult)
			diceThrowResultReported = true
	pass

func _DecreaseDiceAmount(value: int = 1) -> void:
	diceAmount -= value;
	dicesLeftLabel.text = str(diceAmount);
	
func _IncreaseDiceThrowAmount() -> void:
	if dicesToThrow < diceAmount && dicesToThrow < maxAmountToThrow:
		dicesToThrow += 1;
	else:
		#print("Can not increase more!")
		pass
	diceToThrowLabel.text = str(dicesToThrow)
	
func _DecreaseDiceThrowAmount() -> void:
	if dicesToThrow > 1:
		dicesToThrow -= 1;
	else:
		#print("Can not decrease more!")
		pass
	diceToThrowLabel.text = str(dicesToThrow)

func _throwDices() -> void:
	if diceAmount > 0 && !diceThrown:
		diceThrowResultReported = false
		_clearInstanciatedDices()
		fightingSceneNode._resetThrowResult()
		diceThrowResult = 0
		diceThrown = true;
		fightingSceneNode.enemyHolder._decreaseThrowAmount()
		for i in range(dicesToThrow):
			var new_scene = diceSpawner.sceneToInstantiate.instantiate()
			add_child(new_scene)
			diceSpawner.instnciatedDiceArray.append(new_scene)
			_DecreaseDiceAmount();
		if dicesToThrow > diceAmount:
			diceToThrowLabel.text = str(diceAmount)
			dicesToThrow = diceAmount
	pass

func _clearInstanciatedDices() -> void:
	for i in range(diceSpawner.instnciatedDiceArray.size()):
		diceSpawner.instnciatedDiceArray[i]. queue_free()
		
	diceSpawner.instnciatedDiceArray.clear()
