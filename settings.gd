extends Control
@onready var sens = $VBoxContainer/HBoxContainer/SensSlider
@onready var close = $Square3d/XButton
func _ready() -> void:
	sens.value_changed.connect(_on_sens_changed)
	close.pressed.connect(queue_free)

func _on_sens_changed(value: float) -> void:
	Global.sens = value / 2000.0
