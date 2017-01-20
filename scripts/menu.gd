extends Node2D

func _ready():
	set_process_unhandled_input(true)
	
func _unhandled_input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		get_tree().change_scene("res://scenes/level_1.tscn")
