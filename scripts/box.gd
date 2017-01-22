extends RigidBody2D

var spawn = Vector2(0,0)

func _ready():
	spawn = get_pos()
	set_process(true)
	
func _process(delta):
	if get_pos().y > 1000:
		set_linear_velocity(Vector2(0, 0))
		set_pos(spawn)