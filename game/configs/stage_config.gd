class_name StageConfig


enum Keys {
	Island
}



static func get_stage(key: Keys) -> Node:
	return load(STAGEPATHS.get(key)).instantiate()

const STAGEPATHS := {
	Keys.Island : "res://stages/island.tscn"
}
