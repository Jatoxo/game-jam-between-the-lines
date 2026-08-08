extends Control
@onready var team = $RoleCard/Team
@onready var description = $RoleCard/Description
@onready var title = $RoleCard/Title

func set_role(role: String):
	$RoleCard.texture = load(PlayerData.role_path[role])
	title.text = role
	match role:
		"Fact checker":
			team.text = "Constructive"
			team.add_theme_color_override("font_color",Color.DARK_GREEN)
			description.text = "Can correct assumed false information every 2 rounds."
		"Politician":
			team.text = "Constructive"
			team.add_theme_color_override("font_color",Color.DARK_GREEN)
			description.text = "Gets +20 Agenda if other people react to their comments."
		"Boomer":
			team.text = "Constructive"
			team.add_theme_color_override("font_color",Color.DARK_GREEN)
			description.text = "Gets +20 Agenda for every Emoji use"
		"Conspiracy theorist":
			team.text = "Destructive"
			team.add_theme_color_override("font_color",Color.RED)
			description.text = "Can mark a post as „fake news“ every 2 rounds."
		"Bot":
			team.text = "Destructive"
			team.add_theme_color_override("font_color",Color.RED)
			description.text = ""
		"Hater":
			team.text = "Destructive"
			team.add_theme_color_override("font_color",Color.RED)
			description.text = "Can choose someone every three rounds to pass out for a round."
		"Fan":
			team.text = "Constructive"
			team.add_theme_color_override("font_color",Color.DARK_GREEN)
			description.text = "Chooses other player to attach to, then gets all positive or negative scores from that player"
		"Zoomer":
			team.text = "Destructive"
			team.add_theme_color_override("font_color",Color.RED)
			description.text = ""
