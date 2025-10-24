extends Control
@onready var hint_label = $HintLabel
@onready var settings = preload("res://settings.tscn")
func _ready() -> void:
	if Global.japanese:
		hint_label.text = "「クラマー」を手に入れる"
		$Label.text = "E: メニュー"
	else:
		hint_label.text = "Get the Crammer"

func get_two_converter():
	if Global.japanese:
		hint_label.text = "「F」を押して設置する"
	else:
		hint_label.text = "Press F to place"
func is_placed(_coords: Vector3):
	if Global.japanese:
		hint_label.text = "バウンサーを誘い込む"
	else:
		hint_label.text = "Lure Bouncer"
func entity_captured():
	hint_label.visible = false
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == Key.KEY_E and event.pressed:
		var setting = settings.instantiate()
		setting.global_position = Vector2(576, 324)
		add_child(setting)
