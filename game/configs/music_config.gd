extends AudioStreamPlayer
class_name MusicConfig

enum Keys {
	IslandAmbience,
	MainMenuMusic
}

const FILE_PATH := {
	Keys.IslandAmbience : "res://audio/music/island_ambience.ogg",
	Keys.MainMenuMusic : "res://audio/music/transfixed_main_theme.ogg"
}
static func get_audio_stream(keys:Keys) -> AudioStream:
	return load(FILE_PATH.get(keys))
