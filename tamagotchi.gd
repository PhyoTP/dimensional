extends Sprite2D
var current_image = "normal"
var entities = ["snake","bouncer"]
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == Key.KEY_Q:
			pass
func _change_texture(image: String):
	current_image = image
	texture = load("res://tamagotchi/"+image+".png")
