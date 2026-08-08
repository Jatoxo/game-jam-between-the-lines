extends Node
@onready var data = load_json("res://assets/comments/comments.json")
@onready var blanks = data["text"]
@onready var fillers = data["fillers"]
func _ready() -> void:
	print(data)
	print(blanks)

func load_json(path: String):
	if not FileAccess.file_exists(path):
		push_error("File not found: " + path)
		return null

	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(text)
	if error != OK:
		push_error("JSON parse error: %s at line %s" % [json.get_error_message(), json.get_error_line()])
		return null

	return json.data
