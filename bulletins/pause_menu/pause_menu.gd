extends FadingBulletin


const BUTTON_FADE_TIME = 0.15


@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var setting_button: Button = $VBoxContainer/SettingButton
@onready var exit_button: Button = $VBoxContainer/ExitButton

func _ready() -> void:
	resume_button.modulate = TRANSPARENT_COLOR
	setting_button.modulate = TRANSPARENT_COLOR
	exit_button.modulate = TRANSPARENT_COLOR
	
	get_tree().paused = true
	
	super()


func fade_in() -> void:
	super()
	
	var tween := create_tween()
	tween.tween_property(resume_button, "modulate",Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(setting_button, "modulate",Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(exit_button, "modulate",Color.WHITE, BUTTON_FADE_TIME)



func _on_resume_button_pressed() -> void:
	EventSystem.HUD_show_hud.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	fade_out()


#We put in true because in the settings_menu_gd we have function set to false
func _on_setting_button_pressed() -> void:
	EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.SettingsMenu, true)
	fade_out()


func _on_exit_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.MainMenu)
