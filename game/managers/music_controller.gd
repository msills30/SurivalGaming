extends AudioStreamPlayer
class_name MusicController

func _ready() -> void:
	bus = "Music"
	play_music(MusicConfig.Keys.IslandAmbience)


func play_music(key : MusicConfig.Keys) -> void:
	stream = MusicConfig.get_audio_stream(key)
	play()
