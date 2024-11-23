class_name StageConfig


enum Keys {
	Island,
	MainMenu,
	Credits
}



static func get_stage(key: Keys) -> Stage:
	return load(STAGEPATHS.get(key)).instantiate()

const STAGEPATHS := {
	Keys.Island : "res://stages/island/island.tscn",
	Keys.MainMenu : "res://stages/main_menu/main_menu.tscn",
	Keys.Credits : "res://stages/credits/credit_stage.tscn"
}
