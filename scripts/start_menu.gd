extends Control
@onready var buttons: Array[Button] = [$VBoxContainer/PlayButton, $VBoxContainer/SettingsButton, $LanguageButton]
@onready var scenes = {
	0.0: "res://scenes/StartDialogue.tscn",
	1.0: "res://scenes/level1.tscn",
	2.0: "res://scenes/level2.tscn"
}
@onready var main_theme = preload("res://maintheme.tres")
@onready var eng_font = preload("res://Retron2000.ttf")
@onready var jap_font = preload("res://DotGothic16-Regular.ttf")
@onready var settings = preload("res://scenes/settings.tscn")
@onready var vhs = $VHS
var selected_index = 0
func _ready():
	Global.in_menu = true
	buttons[0].pressed.connect(play_pressed)
	buttons[1].pressed.connect(settings_pressed)
	buttons[2].pressed.connect(language_pressed)
	update_language()
	set_focused_button(0)
	for i in range(buttons.size()):
		buttons[i].mouse_entered.connect(set_focused_button.bind(i))
func play_pressed():
	Global.in_menu = false
	vhs.material.set_shader_parameter("static_noise_intensity", 1.0)
	vhs.z_index = 1
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(scenes[Global.currentLevel])
func language_pressed():
	Global.language = abs(Global.language - 1)
	update_language()
func update_language():
	TranslationServer.set_locale(Global.LANGUAGES[Global.language])
	if Global.language == 1:
		main_theme.default_font = jap_font
		buttons[2].text = "English"
	else:
		main_theme.default_font = eng_font
		buttons[2].text = "日本語"
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
