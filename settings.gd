extends Control
@onready var sens = $VBoxContainer/HBoxContainer/SensSlider
@onready var close = $Square3d/XButton
func _ready() -> void:
	sens.drag_ended.connect(set_sens)
	close.pressed.connect(queue_free)
	
func set_sens():
	Global.sens = sens.value/2000
