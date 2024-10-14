extends Node3D

@onready var object_holder: Node3D = $ObjectHolder



func _enter_tree() -> void:
	EventSystem.SPA_spawn_scene.connect(spawn_scene)

func spawn_scene(scene : PackedScene, tform : Transform3D) -> void:
	
	var object := scene.instantiate()
	object.global_transform = tform
	object_holder.add_child(object)
