extends Control
@onready var play_button = $VBoxContainer/PlayButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var start_dialogue = preload("res://StartDialogue.tscn")
var selected_button
func _ready():
	play_button.pressed.connect(play_pressed)
	settings_button.pressed.connect(settings_pressed)
	set_focused_button(play_button)
	play_button.connect("mouse_entered", Callable(self, "set_focused_button").bind(play_button))
	settings_button.connect("mouse_entered", Callable(self, "set_focused_button").bind(settings_button))
func play_pressed():
	get_tree().change_scene_to_packed(start_dialogue)
func settings_pressed():
	print("settings pressed")
func set_focused_button(button: Button):
	var style_normal = StyleBoxFlat.new()
	style_normal.bg_color = Color8(232,81,18)
	if selected_button:
		selected_button.remove_theme_stylebox_override("normal")
		selected_button.text = selected_button.text.erase(selected_button.text.length()-1)
	selected_button = button
	selected_button.add_theme_stylebox_override("normal",style_normal)
	selected_button.text += ">"
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		set_focused_button(settings_button)
	elif Input.is_action_pressed("ui_up"):
		set_focused_button(play_button)
	elif Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_right"):
		selected_button == play_button if play_pressed() else settings_pressed()
		
	
