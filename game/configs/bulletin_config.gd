class_name BulletinConfig

enum Keys {
	InteractionPrompt,
	CraftingMenu,
	CookingMenu,
	PauseMenu
}

static func get_bulletin(key: Keys) -> Bulletin:
	return load(BULLETINPATHS.get(key)).instantiate()

const BULLETINPATHS := {
	Keys.InteractionPrompt : "res://bulletins/interaction_prompt.tscn",
	Keys.CraftingMenu : "res://bulletins/player_menus/crafting_menu.tscn",
	Keys.CookingMenu : "res://bulletins/cooking_menu/cooking_menu.tscn",
	Keys.PauseMenu : "res://bulletins/pause_menu.tscn"
}


