extends Control
var index = 0
@onready var dialogue = $DialogueLabel
# Called when the node enters the scene tree for the first time.

func _process(_delta: float) -> void:
	var current_line = tr("dialogue_2a-%d" % index)
	if index != 0 and dialogue.text != current_line:
		dialogue.text+=current_line[len(dialogue.text)]
func _captured():
	visible = true
	index += 1
	dialogue.text = ""
	await get_tree().create_timer(5.0).timeout
	index += 1
	dialogue.text = ""
	await get_tree().create_timer(5.0).timeout
	index += 1
	dialogue.text = ""
