extends FadingBulletin


@onready var music_volume_label: Label = %MusicVolumeLabel
@onready var sfx_volume_label: Label = %SFXVolumeLabel
@onready var resolution_scale_label: Label = %ResolutionScaleLabel

@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SFXVolumeSlider
@onready var resolution_scale_slider: HSlider = %ResolutionScaleSlider
@onready var ssaa_check_button: CheckButton = %SSAACheckButton
@onready var fullscreen_check_button: CheckButton = %FullScreenCheckButton



var open_pause_menu_after_closing := false


func initialize(_open_pause_menu_after_closing : bool) -> void:
	open_pause_menu_after_closing = _open_pause_menu_after_closing


func _ready() -> void:
	EventSystem.SET_ask_settings_resource.emit(set_settings_visuals)
	
	music_volume_slider.value_changed.connect(_on_music_volume_slider_value_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_slider_value_changed)
	resolution_scale_slider.value_changed.connect(_on_resolution_scale_slider_value_changed)
	ssaa_check_button.toggled.connect(_on_ssaa_check_button_toggled)
	fullscreen_check_button.toggled.connect(_on_fullscreen_check_button_toggled)
	
	super()


func fade_in() -> void:
	create_tween().tween_property(background, "color", BG_NORMAL_COLOR, BG_FADE_TIME / 2.0)


func set_settings_visuals(settings_resource : SettingsResource) -> void:
	update_music_volume_label(settings_resource.music_volume)
	music_volume_slider.value = settings_resource.music_volume
	
	update_sfx_volume_label(settings_resource.sfx_volume)
	sfx_volume_slider.value = settings_resource.sfx_volume
	
	update_res_scale_label(settings_resource.res_scale)
	resolution_scale_slider.value = settings_resource.res_scale
	
	ssaa_check_button.button_pressed = settings_resource.ssaa_enabled
	
	fullscreen_check_button.button_pressed = settings_resource.full_screen_enabled


func _on_music_volume_slider_value_changed(value: float) -> void:
	EventSystem.SET_music_volume_changed.emit(value)
	update_music_volume_label(value)

func update_music_volume_label(value: float) -> void:
	music_volume_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	EventSystem.SET_sfx_volume_changed.emit(value)
	update_sfx_volume_label(value)

func update_sfx_volume_label(value: float) -> void:
	sfx_volume_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_resolution_scale_slider_value_changed(value: float) -> void:
	EventSystem.SET_res_scale_changed.emit(value)
	update_res_scale_label(value)

func update_res_scale_label(value: float) -> void:
	resolution_scale_label.text = str(snappedi(value * 100, 1)) + " %"


func _on_ssaa_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	EventSystem.SET_ssaa_changed.emit(toggled_on)


func _on_fullscreen_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	EventSystem.SET_fullscreen_changed.emit(toggled_on)


func _on_close_button_pressed() -> void:
	fade_out()
	
	EventSystem.SET_save_settings.emit()
	
	if open_pause_menu_after_closing:
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.PauseMenu)


func destroy_self() -> void:
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.SettingsMenu)



#@onready var music_volume_label: Label = %MusicVolumeLabel
#@onready var sfx_volume_label: Label = %SFXVolumeLabel
#@onready var resolution_scale_label: Label = %ResolutionScaleLabel
#
#@onready var music_volume_slider: HSlider = %MusicVolumeSlider
#@onready var sfx_volume_slider: HSlider = %SFXVolumeSlider
#@onready var resolution_scale_slider: HSlider = %ResolutionScaleSlider
#@onready var ssaa_check_button: CheckButton = %SSAACheckButton
#@onready var full_screen_check_button: CheckButton = %FullScreenCheckButton
#
#
#var open_pause_menu_after_closing := false
#
#func initialize(_open_pause_menu_after_closing : bool) -> void:
	#_open_pause_menu_after_closing = _open_pause_menu_after_closing
#
#
#func _ready() -> void:
	#EventSystem.SET_ask_setting_resource.emit(set_settings_visuals)
	#
	#music_volume_slider.value_changed.connect(_on_music_volume_slider_value_changed)
	#sfx_volume_slider.value_changed.connect(_on_sfx_volume_slider_value_changed)
	#resolution_scale_slider.value_changed.connect(_on_resolution_scale_slider_value_changed)
	#ssaa_check_button.toggled.connect(_on_ssaa_check_button_toggled)
	#full_screen_check_button.toggled.connect(_on_full_screen_check_button_toggled)
	#
	##if you check on the ready it leads to the ready function in 
	##Fading Bulliten which we are trying to override
	#super()
#
#
#func set_settings_visuals(settings_resource : SettingsReource) -> void:
	#update_music_volume_label(settings_resource.music_volume)
	#music_volume_slider.value = settings_resource.music_volume
	#
	#update_sfx_volume_label(settings_resource.sfx_volume)
	#sfx_volume_slider.value = settings_resource.sfx_volume
	#
	#update_resolution_scale_label(settings_resource.res_scale)
	#resolution_scale_slider.value = settings_resource.res_scale
	#
	#ssaa_check_button.button_pressed = settings_resource.ssaa_enabled
	#
	#full_screen_check_button.button_pressed = settings_resource.full_screen_enabled
#
#
#func _on_music_volume_slider_value_changed(value: float) -> void:
	#EventSystem.SET_music_volume_change.emit(value)
	#update_music_volume_label(value)
#
#func update_music_volume_label(value: float) -> void:
	##str changes to string, snappedi makes float to whole numbers by 1 
	#music_volume_label.text = str(snappedi(value * 100, 1)) + " %"
#
#
#
#func _on_sfx_volume_slider_value_changed(value: float) -> void:
	#EventSystem.SET_sfx_volume_change.emit(value)
	#update_sfx_volume_label(value)
#
#func update_sfx_volume_label(value: float) -> void:
	#sfx_volume_label.text = str(snappedi(value * 100, 1)) + " %"
#
#
#
#func _on_resolution_scale_slider_value_changed(value: float) -> void:
	#EventSystem.SET_res_scale_change.emit(value)
	#update_resolution_scale_label(value)
#
#func update_resolution_scale_label(value: float) -> void:
	#resolution_scale_label.text = str(snappedi(value * 100, 1)) + " %"
#
#
#
#
##We pressed toggle because we dealing with a bool
#func _on_ssaa_check_button_toggled(toggled_on: bool) -> void:
	#EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	#EventSystem.SET_ssaa_change.emit(toggled_on)
#
#
#
#func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	#EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	#EventSystem.SET_fullscreen_change.emit(toggled_on)
#
#
#func _on_close_button_pressed() -> void:
	#fade_out()
	#
	#EventSystem.SET_save_settings.emit()
	#
	#if open_pause_menu_after_closing:
		##True is not needed
		#EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.PauseMenu)
#
##This minor edit overrides the orginal founded in the FadingBulletin
#func destroy_self() -> void:
	#EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.SettingsMenu)
