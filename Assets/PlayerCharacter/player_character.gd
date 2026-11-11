extends CharacterBody3D

@export var speed = 14 #m/s
@export var fall_acceleration = 75 #m/s^2

var target_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("jump") && is_on_floor():
		direction.y += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
	
	# ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	target_velocity.y = direction.y * speed # TODO: make a better jump 
	
	# vertical velocity (literally gravity)
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	# moving the character
	velocity = target_velocity
	move_and_slide()
