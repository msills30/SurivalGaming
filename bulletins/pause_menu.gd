extends Bulletin

const TRANSPARENT_COLOR = Color(0, 0, 0, 0)
const BG_NORMAL_COLOR = Color(0, 0, 0, 0.3)
const BG_FADE_TIME = 0.25
const BUTTON_FADE_TIME = 0.15


@onready var background: ColorRect = $ColorRect

@onready var resume_button: Button = $ColorRect/VBoxContainer/ResumeButton
@onready var setting_button: Button = $ColorRect/VBoxContainer/SettingButton
@onready var exit_button: Button = $ColorRect/VBoxContainer/ExitButton

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	background.color = TRANSPARENT_COLOR
	resume_button.modulate = TRANSPARENT_COLOR
	setting_button.modulate = TRANSPARENT_COLOR
	exit_button.modulate = TRANSPARENT_COLOR
	fade_in()
	EventSystem.HUD_hide_hud.emit()

func fade_in() -> void:
	create_tween().tween_property(background, 'color', BG_NORMAL_COLOR, BG_FADE_TIME)
	
	var tween := create_tween()
	tween.tween_property(resume_button, "modulate",Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(setting_button, "modulate",Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(exit_button, "modulate",Color.WHITE, BUTTON_FADE_TIME)

func fade_out() -> void:
	var tween := create_tween()
	tween.tween_property(self, 'modulate', TRANSPARENT_COLOR, BG_FADE_TIME/2)
	tween.tween_callback(destroy_self)

func destroy_self() -> void:
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.PauseMenu)
	EventSystem.PLA_unfreeze_player.emit()
	EventSystem.HUD_show_hud.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)




func _on_resume_button_pressed() -> void:
	fade_out()




func _on_setting_button_pressed() -> void:
	pass # Replace with function body.




func _on_exit_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.MainMenu)
