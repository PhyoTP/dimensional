extends Area2D
var direction = Vector2.RIGHT
func _ready() -> void:
	rotation = atan2(direction.y, direction.x)
func _physics_process(_delta: float) -> void:
	position += direction * 10
