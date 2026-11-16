extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		var player_pos = body.position
		var diff = player_pos - position
		# Compare which axis had the stronger hit
		if abs(diff.x) >= abs(diff.y):
			body.direction.x = -body.direction.x
		if abs(diff.x) <= abs(diff.y):
			body.direction.y = -body.direction.y
	body.get_node("./BouncePlayer").play()
