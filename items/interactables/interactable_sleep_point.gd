extends Interactable

func start_interaction() -> void:
	EventSystem.PLA_player_sleep.emit()
	EventSystem.SFX_play_dynamic_sfx.emit(SFXConfig.Keys.GetInTent)
