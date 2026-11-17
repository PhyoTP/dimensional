extends Label


var index = 1
@onready var level1 = preload("res://scenes/level1.tscn")
@onready var details = preload("res://Dialogue2.png")
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed:
		index+=1
		if index == 4:
			get_node("../BouncerDocs").visible = true
		if index == 3:
			get_node("../Dialogue").texture = details
		if index > 9:
			get_tree().change_scene_to_packed(level1)
		else:
			text = ""
func _process(_delta: float) -> void:
	var current_line = tr("DIALOGUE_1-"+str(index))
	if text != current_line:
		text+=current_line[len(text)]
