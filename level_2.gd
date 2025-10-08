extends Node2D
var length = 0
var snake_list = []
@onready var block: Area2D = get_node("Block")
var direction = Vector2.RIGHT * 100

func _ready() -> void:
	snake_list = get_tree().get_nodes_in_group("snake")
	length = len(snake_list)
	print(snake_list)
func _on_timer_timeout() -> void:
	var diff = block.position - snake_list[0].position
	if direction.y == 0:
		if not (direction.x > 0 and diff.x > 0 or direction.x < 0 and diff.x < 0):
			if diff.y > 0:
				direction = Vector2.DOWN * 100
			else:
				direction = Vector2.UP * 100
	else:
		if not (direction.y > 0 and diff.y > 0 or direction.y < 0 and diff.y < 0):
			if diff.x > 0:
				direction = Vector2.RIGHT * 100
			else:
				direction = Vector2.LEFT * 100
	var snake_coords = snake_list.map(func(i): return i.position)
	snake_coords.insert(0, snake_coords[0] + direction)
	if snake_coords[0] == block.position:
		length += 1
		block.position = Vector2(850-randi_range(0, 9)*100,50-randi_range(0,9)*100)
	snake_coords = snake_coords.slice(0,length)
	for i in range(length):
		if i >= len(snake_list):
			var newBody = snake_list[-1].duplicate()
			newBody.position = snake_coords[i]
			snake_list.append(newBody)
			add_child(newBody)
		else:
			snake_list[i].position = snake_coords[i]


func _on_block_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		var player_pos = body.position
		var diff = player_pos - block.position
		# Compare which axis had the stronger hit
		if abs(diff.x) >= abs(diff.y):
			body.direction.x = -body.direction.x
		if abs(diff.x) <= abs(diff.y):
			body.direction.y = -body.direction.y
		
