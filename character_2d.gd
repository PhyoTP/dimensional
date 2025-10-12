extends CharacterBody2D

@export var speed: float = 200.0
var direction = Vector2.RIGHT.rotated(randf()*TAU)
@onready var laser = preload("res://tamagotchi/shoot.png")
@onready var captured = preload("res://tamagotchi/captured.png")
@onready var normal = preload("res://tamagotchi/normal.png")
@onready var detected = preload("res://tamagotchi/detected.png")
@onready var beam = preload("res://beam.tscn")
var can_shoot = false
func _physics_process(_delta: float) -> void:
	
	if Input.is_action_pressed("ui_right"):
		if direction.x < 1:
			direction.x += 0.1
	if Input.is_action_pressed("ui_left"):
		if direction.x > -1:
			direction.x -= 0.1
	if Input.is_action_pressed("ui_down"):
		if direction.y < 1:
			direction.y += 0.1
	if Input.is_action_pressed("ui_up"):
		if direction.y > -1:
			direction.y -= 0.1
	if position.x > 850 or position.x < -50:
		direction.x = -direction.x
		$BouncePlayer.play()
	if position.y < -850 or position.y > 50:
		direction.y = -direction.y
		$BouncePlayer.play()
	# Normalize so diagonal movement isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	$Track.rotation = atan2(direction.y, direction.x)
	velocity = direction * speed
	move_and_slide()
func _input(event: InputEvent) -> void:
	if can_shoot and event is InputEventKey and event.keycode == Key.KEY_F and event.pressed:
		var newBeam = beam.instantiate()
		newBeam.direction = direction
		newBeam.position = position
		add_sibling(newBeam)
func _can_shoot():
	$Tamagotchi.texture = laser
	can_shoot = true
func _cant_shoot():
	$Tamagotchi.texture = normal
	can_shoot = false
func _captured():
	$Tamagotchi.texture = captured
	can_shoot = false
	await get_tree().create_timer(3.0).timeout
	$Tamagotchi.texture = detected
	$DetectedPlayer.play()
	
