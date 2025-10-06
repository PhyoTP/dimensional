extends Node2D

var snake_list = []
var length = 0
func _ready() -> void:
	var snake_list = get_tree().get_nodes_in_group("snake")
	length = len(snake_list)
	
	
