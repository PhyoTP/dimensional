extends Control

@onready var respawn = $VBoxContainer/RespawnButton
@onready var label = $Label
func _ready() -> void:
	respawn.pressed.connect(_respawn_clicked)
	if Global.japanese:
		label.text = "死んだ！"
		respawn.text = "リスタート"
func _respawn_clicked():

	# Also try this alternative approach
	get_tree().change_scene_to_file("res://level"+str(int(Global.currentLevel))+".tscn")
	
