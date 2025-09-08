extends Control
@onready var play_button = $VBoxContainer/PlayButton
@onready var language_button = $VBoxContainer/LanguageButton
@onready var start_dialogue = preload("res://StartDialogue.tscn")
@onready var main_theme = preload("res://maintheme.tres")
@onready var eng_font = preload("res://Retron2000.ttf")
@onready var jap_font = preload("res://DotGothic16-Regular.ttf")
var selected_button
func _ready():
	play_button.pressed.connect(play_pressed)
	language_button.pressed.connect(language_pressed)
	if Global.japanese:
		play_button.text = "プレイ"
		main_theme.default_font = jap_font
		language_button.text = "英語/English"
	else:
		play_button.text = "Play"
		main_theme.default_font = eng_font
		language_button.text = "Japanese/日本語"
	set_focused_button(play_button)
	play_button.connect("mouse_entered", Callable(self, "set_focused_button").bind(play_button))
	language_button.connect("mouse_entered", Callable(self, "set_focused_button").bind(language_button))
func play_pressed():
	get_tree().change_scene_to_packed(start_dialogue)
func language_pressed():
	Global.japanese = not Global.japanese
	get_tree().reload_current_scene()
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
		set_focused_button(language_button)
	elif Input.is_action_pressed("ui_up"):
		set_focused_button(play_button)
	elif Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_right"):
		selected_button == play_button if play_pressed() else language_pressed()
		
	
