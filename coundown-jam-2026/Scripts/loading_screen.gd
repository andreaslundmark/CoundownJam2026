extends CanvasLayer
# code typed followed youtube video here https://www.youtube.com/watch?v=m4PfHg3hmSo

signal loading_screen_ready

@export var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()
	pass # Replace with function body.

func _on_progress_changed(new_value: float) -> void:
	pass
	
func _on_load_finnished() -> void:
	animation_player.play_backwards("Transition")
	await animation_player.animation_finished
	queue_free()
