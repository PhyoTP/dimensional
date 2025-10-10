extends Control

@onready var retry = $VBoxContainer/RespawnButton
@onready var label = $Label
func _ready() -> void:
	retry.pressed.connect(_retry_clicked)
	if Global.japanese:
		label.text = "失敗"
		retry.text = "リスタート"
func _retry_clicked():

	get_tree().change_scene_to_file("res://level"+str(Global.currentLevel)+".tscn")
	
