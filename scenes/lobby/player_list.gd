extends ScrollContainer
class_name PlayerList

var playerSlot : PackedScene = load("res://scenes/lobby/player_slot.tscn")


@onready var listBox = $PlayerList

func _ready():
	var children = listBox.get_children()
	for child in children:
		child.queue_free()

func edit_player(id : int, avatar : Texture2D, playerName : String):
	add_player(id, avatar, playerName)

# Add (or edit a player)
func add_player(id : int, avatar : Texture2D, playerName : String):
	var existing = listBox.find_child(str(id), false, false)
	
	var slot
	if(existing):
		slot = existing
	else:
		slot = playerSlot.instantiate()
		slot.name = str(id)
		listBox.add_child(slot)

	slot.set_avatar(avatar)
	slot.set_slot_name(playerName)



func remove_player(id : int):
	var slot_to_remove = listBox.find_child(str(id), false, false)
	listBox.remove_child(slot_to_remove)
	
	slot_to_remove.queue_free()
	
	
	
	
