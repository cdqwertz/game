extends RigidBody2D

var jumps = 3
var max_jumps = 3

var controls = [false, false, false]
var wait = true
var search_block = false
var goto_block =  false
var block = Vector2(0, 0)
var jump_timer = 0

onready var particles = get_node("particles")
onready var player = get_parent().get_node("player")

func _ready():
	set_fixed_process(true)
	set_contact_monitor(true)
	set_process_unhandled_input(true)
	set_max_contacts_reported(4)
	
	randomize()

func _fixed_process(delta):
	if get_pos().y > 1000:
		queue_free()
	
	update_controls(delta)
	
	var velocity = get_linear_velocity()
	
	set_gravity_scale(0)
	velocity.y += 9
	
	var bodies = get_colliding_bodies()
	if jumps < 1 and bodies.size() > 0:
		jumps = max_jumps
		
	if bodies.size() > 0:
		if controls[0]:
			velocity.y = -300
			particles.set_emitting(true)
	
	if controls[1]:
		if velocity.x > 0:
			velocity.x = 0
		velocity.x += -10
	elif controls[2]:
		if velocity.x < 0:
			velocity.x = 0
		velocity.x += 10
	else:
		velocity.x *= 0.8
	
	set_linear_velocity(velocity)

func jump():
	if not(jumps < 1):
		var velocity = get_linear_velocity()
		velocity.y = -300
		jumps -= 1
		particles.set_emitting(true)
		set_linear_velocity(velocity)

func update_controls(delta):
	var player_pos = player.get_pos()
	var pos = get_pos()
	controls = [false, false, false]
	
	jump_timer += delta
	
	if not(wait):
		if jumps > 0 or (not(search_block) and not(goto_block)):
			if player_pos.x < pos.x:
				controls[1] = true
			else:
				controls[2] = true
			
			if player_pos.y + 64 < pos.y and jump_timer > 0.5:
				jump()
				jump_timer = 0
		elif goto_block:
			if jumps > 0:
				goto_block = false
				search_block = false
			else:
				if block.x < pos.x:
					controls[1] = true
				else:
					controls[2] = true
			
		if jumps == 0:
			search_block = true
			
			var space = get_world_2d().get_direct_space_state()
			var ray_1 = space.intersect_ray(pos, pos + Vector2(0, 400), [self])
			if not(ray_1.empty()):
				search_block = false
				
			if search_block:
				var p = []
				var dirs = [Vector2(0, 600),
							Vector2(-600, 0), Vector2(600, 0), 
							Vector2(600, 100), Vector2(-600, 100), 
							Vector2(600, -100), Vector2(-600, -100)]
				
				for dir in dirs:
					var ray_2 = space.intersect_ray(pos, pos + dir, [self])
					if not(ray_2.empty()):
						search_block = false
						goto_block = true
						p.append(ray_2.position)
					
				if p.size() == 1:
					block = p[0]
				elif p.size() > 1:
					var best = 0
					var best_dist = p[0].distance_to(player_pos)
					var i = 0
					for b in p:
						var dist = b.distance_to(player_pos)
						if dist < best_dist:
							print(dist, " best: ", best_dist)
							best = i
							best_dist = dist
						
						i += 1
					
					block = p[best]
	else:
		if pos.distance_to(player_pos) < 500:
			wait = false
	
	