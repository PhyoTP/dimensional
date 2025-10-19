extends Control
@onready var hint_label = $HintLabel
func _ready() -> void:
	if Global.japanese:
		hint_label.text = "「クラマー」を手に入れる"
	else:
		hint_label.text = "Get the Crammer"

func get_two_converter():
	if Global.japanese:
		hint_label.text = "押して設置する"
	else:
		hint_label.text = "Click to place"
func is_placed(_coords: Vector3):
	if Global.japanese:
		hint_label.text = "バウンサーを誘い込む"
	else:
		hint_label.text = "Lure Bouncer"
func entity_captured():
	hint_label.visible = false
