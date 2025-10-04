extends Label

func _ready() -> void:
	if Global.japanese:
		text = "「クラマー」を手に入れる"
	else:
		text = "Get the Crammer"

func get_two_converter():
	if Global.japanese:
		text = "押して設置する"
	else:
		text = "Click to place"
func is_placed(_coords: Vector3):
	if Global.japanese:
		text = "誘い込む"
	else:
		text = "Lure Bouncer"
func entity_captured():
	visible = false
