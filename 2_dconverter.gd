extends Area3D
var positive = true
var placed = false
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	if Global.japanese:
		$CanvasLayer/Label.text = "化け物を捕まえた！"
		$CanvasLayer/VBoxContainer/NextButton.text = "本部に帰る"
	$CanvasLayer/VBoxContainer/NextButton.pressed.connect(next_scene)
@onready var next = preload("res://dialogue2.tscn")
func _process(_delta: float) -> void:
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
	if body.is_in_group("player") and visible == true:
		get_tree().call_group("player", "get_two_converter")
		visible = false
func _on_area_entered(area: Area3D):
	print("boom")
	if area.is_in_group("enemy"):
		$Camera3D.current = true
		$AnimationPlayer.current_animation = "spin"
		get_tree().call_group("player", "entity_captured")
		$AudioStreamPlayer3D.play()
func is_placed(coords: Vector3):
	placed = true
	global_position = coords
	rotation.y = 0
	visible = true

func next_scene():
	print("next")
	get_tree().change_scene_to_packed(next)
