extends TextureRect
class_name InventorySlot

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect

var item_key

func set_item_key(_item_key) -> void:
	item_key = _item_key
	update_icon()

func update_icon() -> void:
	if item_key == null:
		icon_texture_rect.texture = null
		return
	
	icon_texture_rect.texture = ItemConfig.get_item_resource(item_key).icon

#This is where the drag in items(data) "I renamed as origin_slot" comes from #
func _get_drag_data(at_position: Vector2) -> Variant:
	#Remember stick = 0 that's why we use != null
	if item_key != null:
		
		#This allows the image to be shown when dragged
		var drag_preview := TextureRect.new()
		drag_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		drag_preview.texture = icon_texture_rect.texture
		drag_preview.custom_minimum_size = Vector2(80,80)
		drag_preview.modulate = Color(1,1,1, 0.8)
		set_drag_preview(drag_preview)
		EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
		return self
	
	return null

#Edits are being made because of cooking
func _can_drop_data(at_position: Vector2, slot: Variant) -> bool:
	if item_key != null:
		if slot is HotBarSlot:
			return ItemConfig.get_item_resource(item_key).is_equippable
		
		if slot is StartingCookingSlot:
			return ItemConfig.get_item_resource(item_key).cooking_recipe_resource != null
		
		if slot is FinalCookingSlot:
			return false
	
	return slot is InventorySlot
	

# Even more Edits are being made because of cooking
func _drop_data(at_position: Vector2, old_slot: Variant) -> void:
	if old_slot is StartingCookingSlot:
		var temp_on_key = item_key
		EventSystem.INV_add_item_by_index.emit(old_slot, get_index(), self is HotBarSlot)
		old_slot.set_item_key(temp_on_key)
		old_slot.starting_ingredient_disabled.emit()
	
	elif old_slot is FinalCookingSlot:
		EventSystem.INV_add_item_by_index.emit(old_slot.item_key, get_index(), self is HotBarSlot)
		old_slot.set_item_key(null)
		old_slot.cooked_food_taken.emit()
	
	
	else:
		EventSystem.INV_switch_to_item_index.emit(
			old_slot.get_index(), 
			old_slot is HotBarSlot,
			get_index(),
			self is HotBarSlot
			)
	
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
