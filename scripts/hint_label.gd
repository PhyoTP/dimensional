extends Control
@onready var settings = preload("res://scenes/settings.tscn")
@onready var crammer = $crammer
@onready var menu_label = $MenuLabel
@onready var mission = $MissionLabel

func get_two_converter():
	crammer.visible = true
	mission.text = "Place down the Crammer"
func is_placed(_coords: Vector3):
	crammer.visible = false
	mission.text = "Lure Bouncer into the Crammer"
func entity_captured():
	visible = false
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == Key.KEY_E:
			var setting = settings.instantiate()
			setting.global_position = Vector2(576, 324)
			add_child(setting)
		if event.keycode == Key.KEY_R and visible:
			get_tree().reload_current_scene()
