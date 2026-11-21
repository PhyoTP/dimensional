extends Area2D
@onready var blocks = get_tree().get_nodes_in_group("block") + [get_tree().get_first_node_in_group("player")]
@onready var level = preload("res://scenes/black_hole_level.tscn")
var size = 1
func _ready() -> void:
	area_entered.connect(block_entered)
	body_entered.connect(player_entered)
func  _process(_delta: float) -> void:
	for i in blocks:
		if i:
			var diff: Vector2 = global_position - i.global_position
			diff = diff.normalized()
			i.position += diff * scale.x
	var player = get_tree().get_first_node_in_group("player")
	player.get_node("LengthBar").texture = load("res://bars/bar %d.png" % int(scale.x))
	player.get_tree().get_first_node_in_group("player").get_node("ScoreLabel").text = str(int(scale.x))
func block_entered(block: Node2D):
	size += 1
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(size,size), 1)
	block.queue_free()
func player_entered(player: Node2D):
		Global.currentLevel = 2.5
		get_tree().change_scene_to_packed.call_deferred(level)
