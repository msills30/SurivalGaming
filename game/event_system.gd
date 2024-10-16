extends Node
#Do not create multiple globals you will have a 
#Garbage code if you do that

signal BUL_create_bulletin
signal BUL_destroy_bulletin

signal INV_try_to_pickup_item
signal INV_ask_update_inventory
signal INV_inventory_updated
signal INV_hotbar_updated
signal INV_switch_to_item_index
signal INV_add_item
signal INV_delete_crafting_blueprint_cost
signal INV_delete_item_by_index
signal INV_add_item_by_index

signal PLA_freeze_player
signal PLA_unfreeze_player
signal PLA_change_energy
signal PLA_updated_energy
signal PLA_change_health
signal PLA_updated_health

signal EQU_hotkey_pressed
signal EQU_equip_item
signal EQU_unequip_item
signal EQU_active_hotbar_slot_updated
signal EQU_delete_equip_item

signal SPA_spawn_scene

signal SFX_play_sfx



