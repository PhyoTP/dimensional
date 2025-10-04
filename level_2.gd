extends Node2D

func _ready() -> void:
	var newWall = $Wall2D.duplicate()
	for i in range(15):
		newWall.position.x += 72 
		add_child(newWall)
		newWall = newWall.duplicate()
	for i in range(8):
		newWall.position.y += 72
		add_child(newWall)
		newWall = newWall.duplicate()
	newWall = $Wall2D.duplicate()
	for i in range(8):
		newWall.position.y += 72
		add_child(newWall)
		newWall = newWall.duplicate()
	for i in range(14):
		newWall.position.x += 72 
		add_child(newWall)
		newWall = newWall.duplicate()
