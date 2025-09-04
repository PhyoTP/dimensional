extends Area3D
var positive = true
func _process(delta: float) -> void:
	rotate_y(0.05)
	if positive == true:
		translate(Vector3.UP*0.01)
		if position.y > 7.6:
			positive = false
	else:
		translate(Vector3.DOWN*0.01)
		if position.y < 7.4:
			positive = true
	
