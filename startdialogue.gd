extends Label

var eng_dialogue = [
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
var jap_dialogue = [
	"エーイジェント、次元変異取締局へようこそ。",
	"この情報は極秘です。",
	"「ディーヴィーエー」に、次元から現れる化け物を捕まえます。",
	"最初の任務は、「ヴァオンサー」を捕まえることです。",
	"ヴァオンサーは二次元の化け物です、動きを頼って敵を消します。",
	"普通の武器はヴァオンサーに通用しませんが、遭遇すれば致命的です。",
	"これから、「二次元エンティティクラマー」を使って捕まえなくてはいけません。",
	"「クラマー」を設置し、誘い込みます。",
	"健闘を祈ります。"
]
var dialogue = jap_dialogue if Global.japanese else eng_dialogue
var index = 0
@onready var level1 = preload("res://level1.tscn")
@onready var details = preload("res://Dialogue2.png")
func _ready() -> void:
	if Global.japanese:
		get_parent().get_node("Label2").text = "押す"
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		index+=1
		if index >= 4:
			get_node("../Dialogue").texture = details
		if len(dialogue) <= index:
			get_tree().change_scene_to_packed(level1)
		else:
			text = ""
func _process(delta: float) -> void:
	if text != dialogue[index]:
		text+=dialogue[index][len(text)]
