extends Area3D
var positive = true
var placed = false
@onready var win = preload("res://winscene.tscn")
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
func _process(delta: float) -> void:
	if not placed:
		rotate_y(0.05)
		if positive == true:
			translate(Vector3.UP*0.01)
			if position.y > 7.6:
				positive = false
		else:
			translate(Vector3.DOWN*0.01)
			if position.y < 7.4:
				positive = true
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		get_tree().call_group("player", "get_two_converter")
		visible = false
func _on_area_entered(area: Area3D):
	print("boom")
	if area.is_in_group("enemy"):
		get_tree().change_scene_to_packed(win)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func is_placed(coords: Vector3):
	placed = true
	global_position = coords
	rotation.y = 0
	visible = true
