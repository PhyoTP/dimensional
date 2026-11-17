extends Control

@onready var respawn = $VBoxContainer/RespawnButton
@onready var label = $Label
func _ready() -> void:
	respawn.pressed.connect(_respawn_clicked)
func _respawn_clicked():

	# Also try this alternative approach
	get_tree().change_scene_to_file("res://scenes/level"+str(int(Global.currentLevel))+".tscn")
	
