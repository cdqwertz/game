extends Node2D

var objects = []
var state = false

onready var sprite = get_node("AnimatedSprite")

func _ready():
	pass

func _on_area_1_body_enter(body):
	if body.is_in_group("player") or body.is_in_group("box"):
		state = !state
		
		if state == false:
			sprite.set_frame(0)
		else:
			sprite.set_frame(1)
		
		for object in objects:
			object.set_state(get_name(), state)

func _on_area_2_body_enter(body):
	if body.is_in_group("actuator"):
		objects.append(body)
		body.set_state(get_name(), state)

func _on_area_2_body_exit(body):
	if body.is_in_group("actuator"):
		objects.append(body)

