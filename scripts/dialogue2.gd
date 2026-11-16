extends Label

var dialogue = [
	[
		"Good job agent, you successfully completed your first mission.",
        "よくやった、最初の任務をしまいました。"
	],
	[
		"You've earned yourself an Entity Replicator.",
        "「化け物複写機」をもらいます。"
	],
	[
		"An Entity Replicator allows you to turn into the entities that you capture and gain their abilities.",
        "化け物複写機は捕まえた化け物になることの能力がくれます。"
	],
	[
		"For starters, we've added Bouncer into yours.",
        "私達はあなたの複写機にバウンサーを入れました。"
	],
	[
		"Your next mission is in the 2nd Dimension.",
        "次の任務は二次元の世界にあります。"
	],
	[
		"There is a 1 dimensional entity called Snake, which gained the ability to turn and is consuming everything.",
        "「スネーク」という一次元の化け物がある、曲がれるようになった、すべてを食べています。"
	],
	[
		"If things get out of hand, it could be disastrous.",
        "このままでは、取り返しのつかないことになるかもしれない。"
	],
	[
		"Use your Replicator to turn into Bouncer and neutralise it.",
        "複写機を使ってバウンサーになる、スネークを無力化します。"
	],
	[
		"Bouncer can destroy the body of Snake, but the head is much stronger and can eliminate Bouncer.",
        "バウンサーはスネークの胴体を壊せますが、スネークの頭はバウンサーを壊せます。"
	],
	[
		"Press F to start the mission.",
        "「F」を押して任務を始めます。"
	]
]

var index = 0
@onready var details = preload("res://Dialogue2.png")
@onready var level2 = preload("res://scenes/level2.tscn")
var ended = false
func _ready() -> void:
	if Global.language == 1:
		get_parent().get_node("Label2").text = "押す"
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed and not ended:
		index+=1
		if index == 1:
			get_node("../Tamagotchi").visible = true
		if index == 5:
			get_node("../Dialogue").texture = details
		if len(dialogue) <= index:
			get_tree().change_scene_to_packed(level2)
		text = ""
func _process(_delta: float) -> void:
	var current_line = dialogue[index][Global.language]
	if text != current_line:
		text+=current_line[len(text)]
