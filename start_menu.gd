extends Control
@onready var buttons= [$VBoxContainer/PlayButton, $VBoxContainer/SettingsButton, $LanguageButton]
@onready var scenes = {
	0.0: "res://StartDialogue.tscn",
	1.0: "res://level1.tscn",
	2.0: "res://level2.tscn"
}
@onready var main_theme = preload("res://maintheme.tres")
@onready var eng_font = preload("res://Retron2000.ttf")
@onready var jap_font = preload("res://DotGothic16-Regular.ttf")
@onready var settings = preload("res://settings.tscn")
var selected_index = 0
func _ready():
	Global.in_menu = true
	buttons[0].pressed.connect(play_pressed)
	buttons[1].pressed.connect(settings_pressed)
	buttons[2].pressed.connect(language_pressed)
	if Global.japanese:
		main_theme.default_font = jap_font
		buttons[0].text = "プレイ"
		buttons[1].text = "設定"
		buttons[2].text = "English"
	else:
		main_theme.default_font = eng_font
		buttons[0].text = "Play"
		buttons[1].text = "Settings"
		buttons[2].text = "日本語"
	set_focused_button(0)
	for i in range(buttons.size()):
		buttons[i].mouse_entered.connect(set_focused_button.bind(i))
func play_pressed():
	Global.in_menu = false
	get_tree().change_scene_to_file(scenes[Global.currentLevel])
func language_pressed():
	Global.japanese = not Global.japanese
	get_tree().reload_current_scene()
func set_focused_button(index: int):
	if selected_index != index:
		var style_normal = StyleBoxFlat.new()
		style_normal.bg_color = Color8(232,81,18)
		buttons[selected_index].remove_theme_stylebox_override("normal")
		selected_index = index
		buttons[selected_index].add_theme_stylebox_override("normal",style_normal)
func _input(event: InputEvent) -> void:
	if not $AnimationPlayer.is_playing():
		if event.is_action_pressed("ui_down") and event.pressed:
			set_focused_button((selected_index+1)%len(buttons))
		elif event.is_action_pressed("ui_up") and event.pressed:
			set_focused_button((selected_index-1)%len(buttons))
		elif event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_right"):
			buttons[selected_index].emit_signal("pressed")
		
func settings_pressed():
	var setting = settings.instantiate()
	setting.global_position = Vector2(576, 324)
	add_child(setting)
