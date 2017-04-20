extends RigidBody2D

var jumps = 3
var max_jumps = 3

var zoom = Vector2(1.5, 1.5)

onready var particles = get_node("particles")
onready var particles2 = get_node("particles2")
onready var spawn = get_parent().get_node(spawn_name)
onready var camera = get_node("Camera2D")

onready var sample_player = get_node("sample_player_jump")
onready var sample_player_respawn = get_node("sample_player_respawn")
onready var sample_player_coin = get_node("sample_player_coin")

export var is_level_editor = false
export var action_jump = "jump"
export var action_left = "left"
export var action_right = "right"
export var spawn_name = "spawn"

func _ready():
	set_fixed_process(true)
	set_contact_monitor(true)
	set_process_unhandled_input(true)
	set_max_contacts_reported(4)
	
func respawn():
	set_linear_velocity(Vector2(0, 0))
	sample_player_respawn.play("respawn_1")
	set_pos(spawn.get_pos())

func _fixed_process(delta):
	if get_pos().y > 1000:
		respawn()
	
	var velocity = get_linear_velocity()
	
	set_gravity_scale(0)
	velocity.y += 9
	
	var bodies = get_colliding_bodies()
	if jumps < 1 and bodies.size() > 0:
		if not(bodies.size() == 1 and bodies[0].is_in_group("not_climbable")):
			jumps = max_jumps
		
	if bodies.size() > 0:
		if not(bodies.size() == 1 and bodies[0].is_in_group("not_climbable")):
			if Input.is_action_pressed(action_jump):
				velocity.y = -300
				particles.set_emitting(true)
				particles2.set_emitting(false)
			else:
				particles2.set_emitting(true)
	else:
		particles2.set_emitting(false)
	
	if Input.is_action_pressed(action_left):
		if velocity.x > 0:
			velocity.x = 0
		velocity.x += -10
	elif Input.is_action_pressed(action_right):
		if velocity.x < 0:
			velocity.x = 0
		velocity.x += 10
	else:
		velocity.x *= 0.8
	
	set_linear_velocity(velocity)

func _unhandled_input(event):
	if not(jumps < 1) and event.is_action_pressed(action_jump):
		var velocity = get_linear_velocity()
		velocity.y = -300
		jumps -= 1
		particles.set_emitting(true)
		set_linear_velocity(velocity)
		
		sample_player.play("jump_1")
	
	if event.is_action_pressed("zoom_in"):
		if zoom.x > 0.4 and zoom.y > 0.4:
			zoom.x -= 0.1
			zoom.y -= 0.1
		
		camera.set_zoom(zoom)
		
	if event.is_action_pressed("zoom_out"):
		if zoom.x < 2.5 and zoom.y < 2.5:
			zoom.x += 0.1
			zoom.y += 0.1
		camera.set_zoom(zoom)
		
	if event.is_action_pressed("back"):
		if not(is_level_editor):
			global.coins = 0
			global.time = 0
			get_tree().change_scene("res://scenes/select_level.tscn")
		else:
			get_tree().change_scene("res://scenes/level_editor.tscn")
			
	if event.is_action_pressed("set_spawn"):
		spawn.set_pos(get_pos())