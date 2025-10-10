extends Label

func _ready() -> void:
	_cant_shoot()
func _can_shoot():
	if Global.japanese:
		text = "撃って捕まえる"
	else:
		text = "Shoot to capture"
func _cant_shoot():
	if Global.japanese:
		text = "スネークを短くする"
	else: 
		text = "Make Snake as short as possible"
func _captured():
	if Global.japanese:
		text = "「よかった、HQにかえります」"
	else:
		text = "\"Good job agent, now return to HQ.\""
