extends Control
@onready var sens = $VBoxContainer/HBoxContainer/SensSlider
@onready var close = $Square3d/XButton
@onready var back = $VBoxContainer/BackButton
func _ready() -> void:
	sens.value = Global.sens * 2000.0
	sens.value_changed.connect(_on_sens_changed)
	close.pressed.connect(queue_free)
	if not Global.in_menu:
		back.visible = true
		back.pressed.connect(to_menu)
func _on_sens_changed(value: float) -> void:
	Global.sens = value / 2000.0
func to_menu():
	get_tree().change_scene_to_file("res://StartMenu.tscn")
