extends Control

@onready var respawn = $VBoxContainer/RespawnButton
@onready var level1 = preload("res://level1.tscn")
func _ready() -> void:
	respawn.pressed.connect(_respawn_clicked)
func _respawn_clicked():
	print("clicked")
	print("level1 scene: ", level1)
	print("Current scene: ", get_tree().current_scene)

	#var result = get_tree().change_scene_to_packed(level1)
	#print("Scene change result: ", result)

	# Also try this alternative approach
	get_tree().change_scene_to_file("res://level1.tscn")
	
