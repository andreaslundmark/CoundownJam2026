extends Control

@export var initial_scene: StringName =&""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	SceneLoader.load_scene(initial_scene)
	pass # Replace with function body.
