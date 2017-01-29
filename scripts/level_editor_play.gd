extends Node2D


func _ready():
	var objects = []
	for i in ["block", "block_blue", "block_orange", "block_red"]:
		objects.append(load("res://objects/" + i + ".tscn"))
	
	var d = global.get_level_editor_data()
	var type = 0
	for i in d[0]:
		for object in i:
			var my_object = objects[type].instance()
			
			var w = object[2]
			var h = object[3]
			var x = object[0] + w/2.0
			var y = object[1] + h/2.0 + d[1]
			
			my_object.set_pos(Vector2(x*64, y*64))
			my_object.set_scale(Vector2(w, h))
			add_child(my_object)
		type += 1
		
	set_process_unhandled_input(true)
	
func _unhandled_input(event):
	if event.is_action_pressed("play_level"):
		get_tree().change_scene("res://scenes/level_editor.tscn")