extends Area2D

export var spin = false
export var spin_speed = -60
onready var spawn = get_parent().get_node("spawn")

func _ready():
	connect("body_enter", self, "body_enter")
	if spin:
		set_process(true)
		
func _process(delta):
	if spin:
		rotate(deg2rad(spin_speed) * delta)
	
func body_enter(body):
	if body.is_in_group("player"):
		body.set_pos(body.spawn.get_pos())
		body.set_linear_velocity(Vector2(0, 0))
