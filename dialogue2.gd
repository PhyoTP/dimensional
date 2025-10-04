extends Label

var eng_dialogue = [
	"Good job agent, you successfully completed your first mission.",
	"You've earned yourself an Entity Replicator.",
	"An Entity Replicator allows you to turn into the entities that you capture and gain their abilities.",
	"For starters, we've added Bouncer into yours.",
	"To turn into the entities, just select one (Q and E) and hit the middle button (F).",
	"Your next mission is in the 2nd Dimension.",
	"There is a 1 dimensional entity called Snake, which gained the ability to turn and became a 2D being, and is consuming everything.",
	"If things get out of hand, it could be disastrous.",
	"Use your Replicator to turn into Bouncer and neutralise it."
]
var jap_dialogue = [
	"よくやった、最初の任務をしまいました。",
	"..."
]
var dialogue = jap_dialogue if Global.japanese else eng_dialogue
var index = 0
@onready var details = preload("res://Dialogue2.png")
@onready var level2 = preload("res://soon.tscn")
func _ready() -> void:
	if Global.japanese:
		get_parent().get_node("Label2").text = "押す"
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		index+=1
		if index >= 6:
			get_node("../Dialogue").texture = details
		if len(dialogue) <= index:
			get_tree().change_scene_to_packed(level2)
		text = ""
func _process(_delta: float) -> void:
	if text != dialogue[index]:
		text+=dialogue[index][len(text)]
