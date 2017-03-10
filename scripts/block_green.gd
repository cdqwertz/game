extends Area2D

var dir = 1
var speed = 100

func _ready():
	connect("body_enter", self, "body_enter")
	
func body_enter(body):
	if body.is_in_group("player"):
		var v = body.get_linear_velocity()
		v.y = -v.y * 1.5
		if v.y > 0:
			v.y = min(v.y, 1000)
		elif v.y < 0:
			v.y = max(v.y, -1000)
		
		body.set_linear_velocity(v)