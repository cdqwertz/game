extends StaticBody2D

var objects = []

func _ready():
	set_process(true)
	
func _process(delta):
	for object in objects:
		var v = object.get_linear_velocity()
		v.y = -600
		object.set_linear_velocity(v)
		
		if object.is_in_group("player"):
			object.jumps = object.max_jumps

func _on_Area2d_body_enter(body):
	if body.is_in_group("player") or body.is_in_group("entity"):
		objects.append(body)


func _on_Area2d_body_exit(body):
	if body.is_in_group("player") or body.is_in_group("entity"):
		objects.remove(objects.find(body))
