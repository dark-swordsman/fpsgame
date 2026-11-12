extends CharacterBody3D

@export var SPEED: float = 2.3 #m/s
@export var SPRINT_MULT: float = 1.7
@export var JUMP_VELOCITY: float = 2.5
@export var acceleration: float = 0.5
@export var mouse_sensitivity: int = 2
var mouse_sensitivity_scale: float = 0.001
var LOOKAROUND_SPEED: float = mouse_sensitivity * mouse_sensitivity_scale

# view accumulators
var rot_x: float = 0
var rot_y: float = 0

var input_dir: Vector2

func sprintMultiply() -> float:
	if Input.is_action_pressed("sprint"):
		return SPRINT_MULT
	else:
		return 1.0

func _ready() -> void:
	DebugOverlay.register("rot_x", func() -> float: return rot_x)
	DebugOverlay.register("rot_y", func() -> float: return rot_y)	
	DebugOverlay.register("velocity", func() -> Vector3: return velocity)	
	DebugOverlay.register("input_dir", func() -> Vector2: return input_dir)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: Variant) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# TODO: replace with mouse input
		# horizontal will move pivot?
		# vertical will rotate camera?
		
		# accumulate mouse input
		rot_x -= event.screen_relative.x * LOOKAROUND_SPEED
		rot_y -= event.screen_relative.y * LOOKAROUND_SPEED
		
		# protect rot_x from FP precision loss
		rot_x = fmod(rot_x, TAU)
		# limit view up/down
		rot_y = minf(maxf(-TAU/4, rot_y), TAU/4)
		
		$Pivot.transform.basis = Basis()
		$Pivot/Camera3D.transform.basis = Basis()
		$Pivot.rotate(Vector3.UP, rot_x)
		$Pivot/Camera3D.rotate(Vector3.RIGHT, rot_y)

func _physics_process(delta: float) -> void:
	# vertical velocity (literally gravity)
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y += JUMP_VELOCITY
		
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = ($Pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized()).normalized()
	# rotate the direction by the difference in angle between Pivot and Character
	#print_debug(direction.angle_to($Pivot.transform.basis.x))
	#direction.rotated(Vector3.UP, direction.angle_to($Pivot.transform.basis.x))
		
	if is_on_floor():
		if direction:
			velocity = velocity.move_toward(Vector3(direction.x * SPEED * sprintMultiply(), velocity.y, direction.z * SPEED * sprintMultiply()), acceleration * maxf(1, -direction.dot(velocity) * 2))
		else:
			velocity = velocity.move_toward(Vector3(0, velocity.y, 0), acceleration)
	# moving the character

	move_and_slide()
