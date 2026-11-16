extends Label

var dialogue = [
	["Welcome agent, to the Dimension Variance Authority.","エーイジェント、「DVA」へようこそ。"],
	["What you are about to hear is highly classified.","この情報は極秘です。"],
	["Here at the DVA, we capture entities that have escaped their home dimensions and wreck havoc on others.","「DVA」に、次元から現れる化け物を捕まえます。"],
	["Your first mission is to capture Bouncer.","最初の任務は、「バウンサー」を捕まえることです。"],
	["Bouncer is a 2D entity that relies on movement to eliminate its targets.","バウンサーは二次元の化け物です、動きを頼って敵を消します。"],
	["Normal, 3 dimensional weapons dont work on Bouncer, but coming into contact with it is deadly.","普通の武器はバウンサーに通用しませんが、遭遇すれば致命的です。"],
	["Hence, it is imperative that you apprehend it using the 2 Dimensional Entity Crammer.","これから、「二次元化け物クラマー」を使って捕まえなくてはいけません。"],
	["Simply place the crammer and lure Bouncer into it.","「クラマー」を設置し、誘い込みます。"],
	["Good luck agent.","健闘を祈ります。"]
]

var index = 0
@onready var level1 = preload("res://scenes/level1.tscn")
@onready var details = preload("res://Dialogue2.png")
func _ready() -> void:
	if Global.language == 1:
		get_parent().get_node("Label2").text = "押す"
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed:
		index+=1
		if index == 4:
			get_node("../BouncerDocs").visible = true
		if index == 3:
			get_node("../Dialogue").texture = details
		if len(dialogue) <= index:
			get_tree().change_scene_to_packed(level1)
		else:
			text = ""
func _process(_delta: float) -> void:
	var current_line = dialogue[index][Global.language]
	if text != current_line:
		text+=current_line[len(text)]
