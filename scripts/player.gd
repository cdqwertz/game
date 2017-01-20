extends RigidBody2D

var jumps = 3
var max_jumps = 3
onready var particles = get_node("particles")
onready var spawn = get_parent().get_node("spawn")

func _ready():
	set_fixed_process(true)
	set_contact_monitor(true)
	set_process_unhandled_input(true)
	set_max_contacts_reported(4)

func _fixed_process(delta):
	if get_pos().y > 1000:
		set_linear_velocity(Vector2(0, 0))
		set_pos(spawn.get_pos())
	
	var velocity = get_linear_velocity()
	
	set_gravity_scale(0)
	velocity.y += 9
	
	var bodies = get_colliding_bodies()
	if jumps < 1 and bodies.size() > 0:
		jumps = max_jumps
		
	if bodies.size() > 0:
		if Input.is_action_pressed("jump"):
			velocity.y = -300
			particles.set_emitting(true)
	
	if Input.is_action_pressed("left"):
		if velocity.x > 0:
			velocity.x = 0
		velocity.x += -10
	elif Input.is_action_pressed("right"):
		if velocity.x < 0:
			velocity.x = 0
		velocity.x += 10
	else:
		velocity.x *= 0.8
	
	set_linear_velocity(velocity)

func _unhandled_input(event):
	if not(jumps < 1) and event.is_action_pressed("jump"):
		var velocity = get_linear_velocity()
		velocity.y = -300
		jumps -= 1
		particles.set_emitting(true)
		set_linear_velocity(velocity)