extends AudioStreamPlayer
class_name MusicConfig

enum Keys {
	IslandAmbience
}

const FILE_PATH := {
	Keys.IslandAmbience: "res://audio/music/island_ambience.ogg"
}
static func get_audio_stream(keys:Keys) -> AudioStream:
	return load(FILE_PATH.get(keys))
