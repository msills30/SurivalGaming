extends Node

var bulletins := {}

func _enter_tree() -> void:
	EventSystem.BUL_create_bulletin.connect(create_bulletin)
	EventSystem.BUL_destroy_bulletin.connect(destroy_bulletin)
	EventSystem.BUL_remove_all_bulletins.connect(remove_all_bulletins)

func create_bulletin(bulletin_key : BulletinConfig.Keys, extra_arg = null) -> void:
	if bulletins.has(bulletin_key):
		return
	
	var new_bulletin := BulletinConfig.get_bulletin(bulletin_key)
	new_bulletin.initialize(extra_arg)
	add_child(new_bulletin)
	bulletins[bulletin_key] = new_bulletin

func destroy_bulletin(bulletin_key : BulletinConfig.Keys) -> void:
	if not bulletins.has(bulletin_key):
		return
	bulletins[bulletin_key].queue_free()
	bulletins.erase(bulletin_key)

func remove_all_bulletins() -> void:
	for child in get_children():
		child.queue_free()
	
	bulletins.clear()
