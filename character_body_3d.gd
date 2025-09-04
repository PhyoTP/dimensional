extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement (WASD / arrow keys)
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
# Sensitivity
var mouse_sensitivity = 0.005

# Current rotation values
var yaw = 0.0  # horizontal
var pitch = 0.0  # vertical
var is_controlled = true
@onready var camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # locks the mouse
func _input(event):
	if event is InputEventMouseMotion and is_controlled:
		 # Horizontal rotation (yaw)
		yaw -= event.relative.x * mouse_sensitivity
		rotation.y = yaw

		# Vertical rotation (pitch) — clamp to avoid flipping
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -1.5, 1.5)
		camera.rotation.x = pitch
	if event is InputEventKey and event.keycode == Key.KEY_ESCAPE and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		is_controlled = false
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_controlled = true
