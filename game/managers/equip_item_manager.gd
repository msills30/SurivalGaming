extends Node

var active_hotbar_slot
var hotbar : Array

func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(hotbar_updated)
	EventSystem.EQU_hotkey_pressed.connect(hotkey_pressed)
	EventSystem.EQU_delete_equip_item.connect(delete_equip_item)

func _ready() -> void:
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)


func hotbar_updated(_hotbar : Array) -> void:
	hotbar = _hotbar
	
	if active_hotbar_slot != null and hotbar[active_hotbar_slot] == null:
		EventSystem.EQU_unequip_item.emit()
		active_hotbar_slot = null
		EventSystem.EQU_active_hotbar_slot_updated.emit(null)

func hotkey_pressed(hotkey:int) -> void:
	var hotkey_index := hotkey - 1
	
	if hotbar.size() <= hotkey_index or hotbar[hotkey_index] == null:
		return
	
	if hotkey_index != active_hotbar_slot:
		active_hotbar_slot = hotkey_index
		EventSystem.EQU_equip_item.emit(hotbar[hotkey_index])
		EventSystem.EQU_active_hotbar_slot_updated.emit(hotkey_index)
	
	else:
		active_hotbar_slot = null
		EventSystem.EQU_unequip_item.emit()
		EventSystem.EQU_active_hotbar_slot_updated.emit(null)

func delete_equip_item() -> void:
	EventSystem.INV_delete_item_by_index.emit(active_hotbar_slot, true)
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)
	active_hotbar_slot = null


