extends RigidBody2D

const force_strength = 50000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var horizontal_input = 0
	
	if Input.is_action_pressed("playermove_right"):
		horizontal_input += 1
	if Input.is_action_pressed("playermove_left"):
		horizontal_input -= 1
		
	# here
	
	apply_force(force_strength * delta * Vector2(horizontal_input, 0))
