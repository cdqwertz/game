extends Node2D

var item = 0

onready var item_1 = get_node("item_1")
onready var item_2 = get_node("item_2")

func _ready():
	set_process_unhandled_input(true)
	
func _unhandled_input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		if event.pos.y > get_viewport_rect().size.y/2:
			select(1)
		else:
			select(0)
		
	if item != -1 and event.type == InputEvent.MOUSE_BUTTON and event.button_index == 1:
		if item == 0:
			get_tree().change_scene("res://scenes/level_1.tscn")
		else:
			get_tree().change_scene("res://scenes/level_editor.tscn")

func select(i):
	item = i
	if i == 0:
		item_1.set_scale(Vector2(6, 6))
		item_2.set_scale(Vector2(5.5, 5.5))
	else:
		item_1.set_scale(Vector2(5.5, 5.5))
		item_2.set_scale(Vector2(6, 6))