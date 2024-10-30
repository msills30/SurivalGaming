extends Node

const FADE_TIME := 1.0


# Thread allows other animations to be done without freezing such as
# a loading screen 
var thread := Thread.new() 

var is_stage_changing := false


func _enter_tree() -> void:
	EventSystem.STA_change_stage.connect(start_stage_change_sequence)

func _ready() -> void:
	start_stage_change_sequence(StageConfig.Keys.MainMenu)

func start_stage_change_sequence(stage_key: StageConfig.Keys) -> void:
	if is_stage_changing:
		return
	
	is_stage_changing = true
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	EventSystem.Gam_fade_in.emit(FADE_TIME, game_faded_in.bind(stage_key))
	
	var new_stage:Node = StageConfig.get_stage(stage_key)
	add_child(new_stage)
	
	

func game_faded_in(stage_key: StageConfig.Keys) -> void:
	for stage in get_children():
		stage.queue_free()
	
	EventSystem.BUL_remove_all_bulletins.emit()
	
	thread.start(load_stage.bind(stage_key))
