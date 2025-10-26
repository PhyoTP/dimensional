extends CharacterBody2D

@export var speed: float = 200.0
@export var direction = Vector2.RIGHT.rotated(randf()*TAU)
@onready var beam = preload("res://beam.tscn")
@export var target: Node2D
@export var x_bounds = Vector2(2360, -560)
@export var y_bounds = Vector2(-1460, 1460)
@onready var track = preload("res://track.png")
@onready var found = preload("res://found.png")
var can_shoot = false
var snake_captured = false
func _ready() -> void:
	if Global.currentLevel == 2.5:
		$ScoreLabel.visible = false
		$LengthBar.visible = false
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
	if position.x > x_bounds.x or position.x < x_bounds.y:
		direction.x = -direction.x
		$BouncePlayer.play()
	if position.y < y_bounds.x or position.y > y_bounds.y:
		direction.y = -direction.y
		$BouncePlayer.play()
	# Normalize so diagonal movement isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	$Track.rotation = atan2(direction.y, direction.x)
	velocity = direction * speed
	move_and_slide()
	if target:
		var diff = target.position - position
		if diff.x > -576 and diff.x < 576 and diff.y < 274 and diff.y > -274:
			$Chevron.visible = false
		else: 
			$Chevron.visible = true
		if diff.x > 526:
			diff = Vector2(526, diff.y*526/diff.x)
		if diff.y > 274:
			diff = Vector2(diff.x*274/diff.y, 274)
		if diff.x < -526:
			diff = Vector2(-526, diff.y*526/-diff.x)
		if diff.y < -274:
			diff = Vector2(diff.x*274/-diff.y, -274)
		$Chevron.position = diff
		$Chevron.rotation = atan2(diff.y, diff.x)
	else:
		$Chevron.visible = false
func _input(event: InputEvent) -> void:
	if can_shoot and event is InputEventMouseButton and event.pressed:
		var newBeam = beam.instantiate()
		newBeam.direction = direction
		newBeam.position = position
		add_sibling(newBeam)
	if event is InputEventKey and event.keycode == KEY_SHIFT:
		if event.pressed:
			speed = 300
			$Track.texture = found
		else:
			speed = 200  
			$Track.texture = track
func _can_shoot():
	$Tamagotchi._change_texture("laser")
	can_shoot = true
func _cant_shoot():
	$Tamagotchi._change_texture("normal")
	can_shoot = false
func _captured():
	target = null
	$Tamagotchi._change_texture("captured")
	can_shoot = false
	snake_captured = true
	await get_tree().create_timer(3.0).timeout
	$Tamagotchi._change_texture("detected")
	$DetectedPlayer.play()
	await get_tree().create_timer(7.0).timeout
	target = get_tree().get_first_node_in_group("hole")
	
	
	
