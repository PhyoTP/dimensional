extends Node2D
var length = 0
var snake_list: Array[Node] = []
@onready var blocks = []
@onready var death = preload("res://deathscene.tscn")
@onready var snake_body = preload("res://snake_body.tscn")
@onready var block = preload("res://block2d.tscn")
@onready var lose = preload("res://losescene.tscn")
@onready var blackhole = preload("res://blackhole_entity.tscn")
var can_kill = true
var direction = Vector2.RIGHT * 100

func _ready() -> void:
	snake_list = get_tree().get_nodes_in_group("snake")
	length = len(snake_list)
	Global.currentLevel = 2
	snake_list[-1].body_entered.connect(_on_snake_body_entered.bind(snake_list[-1]))
	blocks = get_tree().get_nodes_in_group("block")
	for i in range(8):
		var newBlock = block.instantiate()
		newBlock.position = rand_pos()
		add_child(newBlock)
	blocks = get_tree().get_nodes_in_group("block")
func _on_timer_timeout() -> void:
	blocks = get_tree().get_nodes_in_group("block")
	var block_diffs = blocks.map(func(i): return i.position - snake_list[0].position)
	var min_dist = block_diffs[0]
	var min_index = 0
	for i in range(1, block_diffs.size()):
		if abs(block_diffs[i].x) + abs(block_diffs[i].y) < abs(min_dist.x) + abs(min_dist.y):
			min_dist = block_diffs[i]
			min_index = i
	var diff = min_dist
	var min_block = blocks[min_index]
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
	if snake_list[0].overlaps_area(min_block):
		length += 1
		if length > 10:
			get_tree().change_scene_to_packed(lose)
			return
		min_block.queue_free()
		$CharacterBody2D/ScoreLabel.text = str(length)
		$CharacterBody2D/LengthBar.texture = load("res://bars/bar "+str(length)+".png")
		$Head/PopPlayer.play()
	snake_coords = snake_coords.slice(0,length)
	if length > 1:
		get_tree().call_group("player", "_cant_shoot")
	var tween = create_tween().set_parallel(true)

	for i in range(length):
		if i >= snake_list.size():
			# Instantiate and add a new body segment if needed
			var new_body = snake_body.instantiate()
			new_body.position = snake_coords[i]
			new_body.body_entered.connect(_on_snake_body_entered.bind(new_body))
			snake_list.append(new_body)
			add_child(new_body)
		else:
			# Smoothly move existing segments toward new positions
			tween.tween_property(
				snake_list[i], 
				"position", 
				snake_coords[i], 
				0.5
			)

func _on_head_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("player") and can_kill == true:
		get_tree().change_scene_to_packed(death)
	

func _on_snake_body_entered(body: Node2D, sender: Node2D) -> void:
	print("entered")
	if body in get_tree().get_nodes_in_group("player"):
		var index = snake_list.find(sender)
		for i in snake_list.slice(index):
			i.queue_free()
			var newBlock = block.instantiate()
			newBlock.position = rand_pos()
			add_child(newBlock)
		snake_list = snake_list.slice(0, index)
		if index != -1:
			length = index
			$CharacterBody2D/ScoreLabel.text = str(length)
			$CharacterBody2D/LengthBar.texture = load("res://bars/bar "+str(length)+".png")

func rand_pos() -> Vector2:
	var none = (snake_list + blocks).map(func(i): if is_instance_valid(i): return i.position)
	var pos = Vector2(1850-randi_range(0, 18)*100,950-randi_range(0,18)*100)
	if pos in none:
		return rand_pos()
	else:
		return pos
func _on_head_area_entered(area: Area2D) -> void:
	if area in get_tree().get_nodes_in_group("beam"):
		get_tree().call_group("player", "_captured")
		$Timer.stop()
		$Head/AnimationPlayer.current_animation = "capture"
		can_kill = false
		for i in snake_list:
			i.queue_free()
			var newBlock = block.instantiate()
			newBlock.position = rand_pos()
			add_child(newBlock)
		snake_list = []
		length = 0
		$CharacterBody2D/ScoreLabel.text = str(length)
		$CharacterBody2D/LengthBar.texture = load("res://bars/bar "+str(length)+".png")
		await get_tree().create_timer(1.0).timeout
		await get_tree().create_timer(9.0).timeout
		var hole = blackhole.instantiate()
		hole.position = rand_pos()
		add_child(hole)
		
