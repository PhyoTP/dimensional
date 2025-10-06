extends CharacterBody2D

@export var speed: float = 200.0
var direction = Vector2.RIGHT.rotated(randf()*TAU)

func _physics_process(delta: float) -> void:
	
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
