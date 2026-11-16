extends Sprite2D
var current = "Shoot beam"
@onready var label = $VBoxContainer/Label
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var index = Global.modes.find(current)
		if index != -1:
			if event.keycode == Key.KEY_Q:
				_set_mode(Global.modes[(index-1)%Global.modes.size()])
			elif event.keycode == Key.KEY_E:
				_set_mode(Global.modes[(index+1)%Global.modes.size()])
		if event.keycode == Key.KEY_F:
			get_tree().call_group("player", "_replicator", current)
func _detected():
	_set_mode("Detected")
func _set_mode(mode: String):
	current = mode
	$Bouncer.visible = mode == "Bouncer"
	$Snake.visible = mode == "Snake"
	$Detected.visible = mode == "Detected"
	label.text = mode
func _add_mode(mode: String):
	Global.modes.append(mode)
	_set_mode(mode)
