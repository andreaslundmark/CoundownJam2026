extends Control

@export var initial_scene: StringName = &""

func _on_start_game_pressed() -> void:
	SceneLoader.load_scene(initial_scene)
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
