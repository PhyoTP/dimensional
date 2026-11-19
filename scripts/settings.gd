extends Control
@onready var sens = $VBoxContainer/HBoxContainer/SensSlider
@onready var close = $Square3d/XButton
@onready var back = $VBoxContainer/HBoxContainer2/BackButton
@onready var reset = $VBoxContainer/HBoxContainer2/ResetButton
func _ready() -> void:
	sens.value = Global.sens * 2000.0
	sens.value_changed.connect(_on_sens_changed)
	close.pressed.connect(queue_free)
	if Global.in_menu:
		back.visible = false
		reset.visible = false
	else:
		reset.visible = true
		back.visible = true
		back.pressed.connect(to_menu)
		reset.pressed.connect(reset_level)
func _on_sens_changed(value: float) -> void:
	Global.sens = value / 2000.0
func to_menu():
	get_tree().change_scene_to_file("res://scenes/StartMenu.tscn")
func reset_level():
	get_tree().reload_current_scene()
