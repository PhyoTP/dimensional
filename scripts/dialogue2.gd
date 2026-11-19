extends Label

var index = 1
@onready var details = preload("res://Dialogue2.png")
@onready var level2 = preload("res://scenes/level2.tscn")
var ended = false
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed and not ended:
		index+=1
		if index == 1:
			get_node("../Tamagotchi").visible = true
		if index == 5:
			get_node("../Dialogue").texture = details
		if index > 10:
			get_tree().change_scene_to_packed(level2)
		text = ""
func _process(_delta: float) -> void:
	var current_line = tr("DIALOGUE_2-%d" % index)
	if text != current_line:
		text+=current_line[len(text)]
