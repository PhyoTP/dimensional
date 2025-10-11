extends Area3D
var rand_angle = randf() * TAU
var direction = Vector3(cos(rand_angle), 0, sin(rand_angle))
@onready var death = preload("res://deathscene.tscn")
@onready var track = preload("res://track.png")
@onready var found = preload("res://found.png")
var caught = false
var speed = 5
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	$MeshInstance3D.rotation.y = atan2(direction.x, direction.z) - PI/2
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("block"):
		var my_pos = global_transform.origin
		var block_pos = body.global_transform.origin
		var diff = my_pos - block_pos

		# Compare which axis had the stronger hit
		if abs(diff.x) > abs(diff.z):
			direction.x = -direction.x
		else:
			direction.z = -direction.z
		$MeshInstance3D.mesh.material.albedo_texture = track
		$BouncePlayer.play()
		speed = 5
	if body.is_in_group("player"):
		print("dead")
		get_tree().change_scene_to_packed(death)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _on_area_entered(area: Node3D):
	if area.is_in_group("converter"):
		caught = true
		var my_pos = global_transform.origin
		var conv_pos = area.global_transform.origin
		var diff = conv_pos - my_pos
		var dist = sqrt(diff.x**2 + diff.y**2 + diff.z**2)
		var ratio = dist/27
		direction = Vector3(diff.x*ratio, diff.y*ratio, diff.z*ratio)
		$AnimationPlayer.current_animation = "caught"
		$AnimationPlayer.animation_finished.connect(queue_free)
func player_on_ground():
	if not caught:
		var player = get_tree().get_nodes_in_group("player")[0]
		var my_pos = global_transform.origin
		var player_pos = player.global_transform.origin
		var diff =	player_pos - my_pos
		var dist = sqrt(diff.x**2 + diff.z**2)
		var ratio = 1/dist
		direction = Vector3(diff.x*ratio, 0, diff.z*ratio)
		speed = 7.5
		$MeshInstance3D.mesh.material.albedo_texture = found
		if not $FoundPlayer.playing:
			$FoundPlayer.play()
		print(direction)
		print($MeshInstance3D.rotation.y)
