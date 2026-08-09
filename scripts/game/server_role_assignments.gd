extends Control

@onready 
var ack_counter = $Count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Lobby.active_game:
		role_acknowledged(-1, 0, len(Lobby.active_game.playerStates))
		Lobby.active_game.assignRoles()
		Lobby.active_game.new_role_acknowledged.connect(role_acknowledged)


func role_acknowledged(player_id, count, total):
	print("New ack came in: %d" % player_id)
	print("%d / %d" % [count, total])
	
	ack_counter.text = "%d / %d" % [count, total]
	
	if(count == total):
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/feed.tscn")
		print("Trying to switch client scene")
		Lobby.switch_client_scene.rpc("res://scenes/feed.tscn")
		
