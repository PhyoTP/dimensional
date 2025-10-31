extends Control
@onready var settings = preload("res://settings.tscn")
@onready var crammer = $crammer
func _ready() -> void:
	if Global.japanese:
		$Label.text = "E: メニュー"

func get_two_converter():
	crammer.visible = true
func is_placed(_coords: Vector3):
	crammer.visible = false
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == Key.KEY_E and event.pressed:
		var setting = settings.instantiate()
		setting.global_position = Vector2(576, 324)
		add_child(setting)
