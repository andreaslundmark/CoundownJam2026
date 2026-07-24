extends Node

@export var enemyName:RichTextLabel;
@export var enemyFlavourText:RichTextLabel;
@export var enemyEffect1:RichTextLabel;
@export var enemyEffect2:RichTextLabel;
@export var enemyEffect3:RichTextLabel;
@export var enemyEffect4:RichTextLabel;
@export var enemyHealthAmount:Label;

@export var enemyHealth: int = 30;

var goldReward:int = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _decreaseEnemyHealth(value: int):
	enemyHealth -= value;
	enemyHealthAmount.text = str(enemyHealth)
	
	
func _enemyDead():
	pass
