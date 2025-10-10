extends Area2D
var direction = Vector2.RIGHT
func _ready() -> void:
	rotation = atan2(direction.y, direction.x)
func _physics_process(_delta: float) -> void:
	position += direction * 10


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("snake") or area.is_in_group("block"):
		queue_free()
