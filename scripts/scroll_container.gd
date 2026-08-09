extends ScrollContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for entry in MockServer.round_comments:
		var scene = load("res://scenes/comment_card.tscn")
		var instance = scene.instantiate()
		instance.comment = "[%s]\n%s" % [entry["role"], entry["text"]]
		$VBoxContainer.add_child(instance)

	MockServer.end_round()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
