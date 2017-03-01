extends StaticBody2D

var state = false
var states = {}

export var always_on = false

onready var collider = get_node("CollisionShape2D")

func _ready():
	set_process(true)
	
func _process(delta):
	if state or always_on:
		set_opacity(0.3)
		collider.set_trigger(true)
	else:
		set_opacity(1.0)
		collider.set_trigger(false)

func set_state(name, value):
	states[name] = value
	update_state()
	
func update_state():
	for name in states.keys():
		if not(states[name]):
			state = false
			return
	state = true