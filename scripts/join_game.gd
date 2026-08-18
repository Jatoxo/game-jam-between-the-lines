extends "res://scripts/ui_screen.gd"

@onready var entryField = $IPEntry
@onready var errorLabel = $ErrorLabel
@onready var errorTimer = $ErrorLabel/Timer
@onready var joinButton = $Background/Button


func _ready():
	Lobby.player_connected.connect(peer_connected)

func peer_connected(id, info):
	if(id == 1):
		print("Connected to server!")
		get_tree().change_scene_to_file("res://scenes/lobby/player_creation.tscn")

# "join" button
func _on_button_pressed() -> void:
	var address = entryField.text.strip_edges()
	
	if not is_valid_address(address):
		display_error("Invalid IP")
	
	address = address.split(":")
	
	if len(address) == 1:
		var ip   = address[0]
		Lobby.join_game(ip)
		
	else:
		var ip   = address[0]
		var port = int(address[1])
		
		Lobby.join_game(ip, port)


# True if the string represents a valid ipv4 with or without port
func is_valid_address(address : String):
	if len(address) == 0:
		return false
	
	# If just IP, assume default port
	if is_valid_ipv4(address):
		return true
	
	var ip_and_port = address.split(":")
	
	if not is_valid_ipv4(ip_and_port[0]) or not ip_and_port[1].is_valid_int():
		return false
		
	return true

var regex = RegEx.create_from_string(
	"^(?:(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)$"
)
func is_valid_ipv4(ip: String) -> bool:
	return regex.search(ip) != null


func display_error(error : String):
	print(error)
	
	errorLabel.text = error
	
	errorLabel.visible = true
	errorTimer.start()


func _on_timer_timeout() -> void:
	errorLabel.visible = false


func _on_ip_entry_text_changed(new_text: String) -> void:
	joinButton.disabled = not is_valid_address(new_text)


func _on_ip_entry_text_submitted(new_text: String) -> void:
	_on_button_pressed()
