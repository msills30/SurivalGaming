extends Stage

#That function is currently being used in the stage.gd
#func _ready() -> void:
	#EventSystem.MUS_play_music.emit(MusicConfig.Keys.MainMenuMusic)

func _on_start_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.Island)



func _on_setting_button_pressed() -> void:
	EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.SettingsMenu, false)



func _on_credits_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.Credits)



func _on_exit_button_pressed() -> void:
	get_tree().quit()

