extends TextureButton

@export var moves : Node
@export var snapBack : Node

var dragging = false
var drag_offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("button_down", _on_button_button_down)
	connect("button_up", _on_button_button_up)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		moves.global_position = get_global_mouse_position() - drag_offset


func _on_button_button_down() -> void:
	dragging = true
	drag_offset = get_global_mouse_position() - moves.global_position
	

func _on_button_button_up() -> void:
	dragging = false
	if snapBack:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(moves, "global_position", snapBack.global_position, 0.5)
