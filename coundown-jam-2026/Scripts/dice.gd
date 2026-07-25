extends RigidBody3D

@onready var diceChildren = $ChildFaces.get_children()
@export var diceFaceSelected:Node3D;
var diceStartPos;
var throwStrengt = 30;

var isRolling: bool = false
signal rollFinished(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	throwStrengt = randf_range(60,180)
	diceStartPos = global_position;
	_rollDice(); #we roll the dice in ready because we will instantiate them
	pass # Replace with function body.
	
func _rollDice() -> void:
	#resetState
	#print("Roll Dice")
	isRolling = true;
	diceFaceSelected = null;
	sleeping = false
	freeze = false
	transform.origin = diceStartPos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	#rotate dice randomly
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2*PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2*PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2*PI)) * transform.basis
	
	var throw_vector = Vector3(randf_range(-1,1),0,randf_range(-1,1)).normalized()
	angular_velocity = throw_vector * throwStrengt /2
	apply_central_impulse(throw_vector * throwStrengt)


func _on_sleeping_state_changed() -> void:
	var highestYValue:int = 0;
	if sleeping:
		for i in diceChildren:
			if i.global_position.y > highestYValue:
				highestYValue = i.global_position.y
				diceFaceSelected = i
	
	isRolling = false		
	rollFinished.emit(diceFaceSelected.integerValue)	
	print(diceFaceSelected.name)
			
	pass # Replace with function body.
