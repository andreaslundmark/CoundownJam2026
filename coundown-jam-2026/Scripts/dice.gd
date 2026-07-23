extends RigidBody3D

@onready var diceChildren = $ChildFaces.get_children()

var dice_start_pos;
var throw_strengt = 30;
@export var diceFaceSelected:Node3D;

var is_rolling: bool = false

signal roll_finished(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dice_start_pos = global_position;
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("ui_accept") && !is_rolling:
		print("Roll Dice")
		_rollDice();
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _rollDice():
	#resetState
	is_rolling = true;
	diceFaceSelected = null;
	sleeping = false
	freeze = false
	transform.origin = dice_start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	#rotate dice randomly
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2*PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2*PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2*PI)) * transform.basis
	
	var throw_vector = Vector3(randf_range(-1,1),0,randf_range(-1,1)).normalized()
	angular_velocity = throw_vector * throw_strengt /2
	apply_central_impulse(throw_vector * throw_strengt)


func _on_sleeping_state_changed() -> void:
	var highestYValue:int = 0;
	if sleeping:
		for i in diceChildren:
			if i.global_position.y > highestYValue:
				highestYValue = i.global_position.y
				diceFaceSelected = i
	
	is_rolling = false		
	roll_finished.emit(diceFaceSelected.integerValue)	
	print(diceFaceSelected.name)
			
	pass # Replace with function body.
