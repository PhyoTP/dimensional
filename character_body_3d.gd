extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var two_converter = preload("res://2dconverter.tscn")
var converter = null
var material = preload("res://2dconverter.tres")
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
func _process(delta: float) -> void:
	if abs(position.y-1.5) <= 0.1:
		get_tree().call_group("enemy", "player_on_ground")
	if converter:
		var height_diff = camera.global_position.y - 1.5
		# Forward direction of the camera projected onto XZ
		var forward = Vector3(
			-sin(camera.global_rotation.y),
			0,
			-cos(camera.global_rotation.y)
		).normalized()

		# Distance along forward direction, using pitch (rotation.x)
		var distance = height_diff / tan(-camera.global_rotation.x)

		# Final position
		var pos = camera.global_position + forward * distance
		pos.y = 1.5

		converter.global_position = pos
		converter.global_rotation.y = 0.0
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
		if is_controlled and converter:
			get_tree().call_group("converter", "is_placed", converter.global_position)
			material.albedo_color.a = 1.0
			converter.queue_free()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_controlled = true
	
	

func get_two_converter():
	print("obtained")
	converter = two_converter.instantiate()
	material.albedo_color.a = 0.5
	add_child(converter)



	
