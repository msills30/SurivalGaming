extends HBoxContainer

func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(update_hotbar)
	EventSystem.EQU_active_hotbar_slot_updated.connect(update_active_slot)


func update_hotbar(idx:Array) -> void:
	for slot in get_children():
		slot.set_item_key(idx[slot.get_index()])


func update_active_slot(idx) -> void:
	for slot in get_children():
		slot.set_highlighted(slot.get_index() == idx)
