extends Node2D

var selected_object = 0
var zoom = Vector2(1.5, 1.5)
var show_menu = false

onready var menu = get_node("gui/menu")
onready var camera = get_node("Camera2D")
onready var level = get_node("level")

func _ready():
	menu.hide()
	set_process(true)
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if Input.is_mouse_button_pressed(1):
		var pos = get_global_mouse_pos()
		pos = pos - level.get_pos()
		pos = Vector2(floor(pos.x/64), floor(pos.y/64))
		level.set_block(pos, selected_object)
		level.update()
	
	if Input.is_mouse_button_pressed(2):
		var pos = get_global_mouse_pos()
		pos = pos - level.get_pos()
		pos = Vector2(floor(pos.x/64), floor(pos.y/64))
		level.set_block(pos, -1)
		level.update()
		
	if event.is_action_pressed("zoom_in"):
		if zoom.x > 0.4 and zoom.y > 0.4:
			zoom.x -= 0.1
			zoom.y -= 0.1
		
		camera.set_zoom(zoom)
		
	if event.is_action_pressed("zoom_out"):
		if zoom.x < 4.5 and zoom.y < 4.5:
			zoom.x += 0.1
			zoom.y += 0.1
		camera.set_zoom(zoom)
		
	if event.is_action_pressed("play_level"):
		level.play_level()
		
	if event.is_action_pressed("back"):
		get_tree().change_scene("res://scenes/menu.tscn")
		
func _process(delta):
	var speed = 800
	if Input.is_action_pressed("slow"):
		speed = 300
	
	var v = Vector2(0, 0)
	if Input.is_action_pressed("down"):
		v.y = speed
	elif Input.is_action_pressed("jump"):
		v.y = -speed
		
	if Input.is_action_pressed("left"):
		v.x = -speed
	elif Input.is_action_pressed("right"):
		v.x = speed
		
	camera.set_pos(camera.get_pos() + v*delta)

func select(s):
	selected_object = s

func _on_menu_pressed():
	show_menu = !show_menu
	if show_menu:
		menu.show()
	else:
		menu.hide()

func _on_button_new_level_pressed():
	level.set_pos(Vector2(0, 0))
	level.width = 32
	level.height = 16
	level.clear_level()
	
	show_menu = false
	menu.hide()
	level.update()


func _on_button_load_level_pressed():
	level.load_level("user://level.txt")
	show_menu = false
	menu.hide()
	level.update()

func _on_button_save_level_pressed():
	level.save_level("user://level.txt")
	show_menu = false
	menu.hide()
	level.update()
