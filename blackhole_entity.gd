extends Area2D
@onready var blocks = get_tree().get_nodes_in_group("block") + get_tree().get_nodes_in_group("player")
func _ready() -> void:
	area_entered.connect(thing_entered)
func  _process(_delta: float) -> void:
	for i in blocks:
		if i:
			var diff = global_position - i.global_position
			var length = sqrt(diff.x**2 + diff.y**2)
			i.position += diff * scale.x / length
	var player = get_tree().get_first_node_in_group("player")
	player.get_node("LengthBar").texture = load("res://bars/bar "+str(int(scale.x))+".png")
	player.get_tree().get_first_node_in_group("player").get_node("ScoreLabel").text = str(int(scale.x))
func thing_entered(thing: Node2D):
	var tween = create_tween()
	tween.tween_property(self, "scale", scale+Vector2(1,1), 1)
	thing.queue_free()
	print(scale)
	
