extends Node

class_name Stage

signal loading_complete

@export var show_mouse := false
@export var music_to_play := MusicConfig.Keys.MainMenuMusic
@export var scatter_nodes : Array[Node3D] = []

var scatter_nodes_ready := 0

func _ready() -> void:
	EventSystem.MUS_play_music.emit(music_to_play)
	

	for scatter_node in scatter_nodes:
		#The build_complete is a built-in signal from the Scatter Add-on
		if scatter_node.has_signal('build_completed'):
			scatter_node.build_completed.connect(scatter_nodes_loaded)
			

func scatter_nodes_loaded() -> void:
	scatter_nodes_ready += 1
	
	if scatter_nodes_ready >= scatter_nodes.size():
		loading_complete.emit()
		
		if show_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

