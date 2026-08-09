extends Node
# Simuliert den Server für Testzwecke ohne Netzwerk/Lobby.
# Wird nur verwendet, wenn active == true.

const ROLES := ["Factchecker", "Politician", "Boomer", "Fan", "Hater", "Bot", "Conspiracy Theorist", "Zoomer"]

var active := false
var player_role : String = ""
var bot_roles : Array = []
var round_comments : Array = [] # [{role, text, color}]


func start_game() -> void:
	active = true
	var roles = ROLES.duplicate()
	roles.shuffle()
	player_role = roles[0]
	bot_roles = roles.slice(1)
	round_comments.clear()
	
func build_comment_text(blank: String, filler_text: String) -> String:
	var text1 = ""
	var text2 = ""
	var x = 0
	while blank[x] != "[":
		text1 += blank[x]
		x += 1
	x += 7
	while x < len(blank):
		text2 += blank[x]
		x += 1
	return text1 + " " + filler_text + text2
	
func submit_player_comment(blank: String, filler: Dictionary) -> void:
	var comment = build_comment_text(blank, filler["text"])
	Global.game.apply_comment(filler)
	round_comments.append({
		"role": player_role,
		"text": comment,
		"color": Color(0.75, 0.92, 0.78)
	})
	_simulate_all_bots()
	
func _simulate_bot_comment(role_name: String) -> void:
	var blanks = ResourceGlobal.blanks.duplicate()
	var fillers = ResourceGlobal.fillers.duplicate()
	blanks.shuffle()
	fillers.shuffle()
	var chosen_blank = blanks[0]
	var chosen_filler = fillers[0]

	Global.game.apply_comment(chosen_filler)
	round_comments.append({
		"role": role_name,
		"text": build_comment_text(chosen_blank, chosen_filler["text"]),
		"color": Color(0.75, 0.92, 0.78)
	})

func _simulate_all_bots() -> void:
	for role in bot_roles:
		_simulate_bot_comment(role)

func end_round() -> void:
	active = false
	round_comments.clear()
