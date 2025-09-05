extends Label

var dialogue = [
	"Welcome agent, to the Dimension Variance Authority.",
	"What you are about to hear is highly classified.",
	"Here at the DVA, we capture entities that have escaped their home dimensions and wreck havoc on others.",
	"Your first mission is to capture Bouncer.",
	"Bouncer is a 2D entity that relies on movement to eliminate its targets.",
	"Normal, 3 dimensional weapons dont work on Bouncer, but coming into contact with it is deadly.",
	"Hence, it is imperative that you apprehend it using the 2 Dimensional Entity Crammer.",
	"Simply place the crammer and lure Bouncer into it.",
	"Good luck agent."
]
var index = 0
@onready var level1 = preload("res://level1.tscn")
@onready var details = preload("res://Dialogue2.png")
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		index+=1
		if index >= 4:
			get_node("../Dialogue").texture = details
		if len(dialogue) <= index:
			get_tree().change_scene_to_packed(level1)
		else:
			text = dialogue[index]
