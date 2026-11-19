extends Label
func _ready() -> void:
	if Global.currentLevel == 2:
		if Global.language == 1:
			text = "複写機を使ってスネークを捕まえる"
		else:
			text = "Capture Snake using the Entity Replicator"
	elif Global.currentLevel == 2.5:
		text = "Hello agent, can you hear me?"
		await get_tree().create_timer(3.0).timeout
		text = "You're currently in a black hole."
		await get_tree().create_timer(2.0).timeout
		text = "You might see a white ring, don't go in it yet."
		await get_tree().create_timer(3.0).timeout
		text = "These black holes are how these entities have been \nescaping to other dimensions."
		await get_tree().create_timer(5.0).timeout
		text = "Recently, there's been more of them popping up."
		await get_tree().create_timer(3.0).timeout
		text = "We think it's the work of a group called the Gravitators."
		await get_tree().create_timer(3.0).timeout
		text = "They create these black holes in different dimensions,"
		await get_tree().create_timer(3.0).timeout
		text = "so entities will go into them to wreck havoc."
		await get_tree().create_timer(3.0).timeout
		text = "The white ring is a wormhole that connects two dimensions."
		await get_tree().create_timer(3.0).timeout
		text = "According to our readings, this one is to the first dimension."
		await get_tree().create_timer(3.0).timeout
		text = "Use your Replicator to turn into Snake, then go in the wormhole."
		await get_tree().create_timer(3.0).timeout
		text = "Find the branch of the DVA in that dimension,"
		await get_tree().create_timer(3.0).timeout
		text = "and they'll tell you what to do."

	
