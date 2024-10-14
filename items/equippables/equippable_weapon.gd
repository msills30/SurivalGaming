extends EquippableItem
class_name EquippableWeapon

@onready var hit_check_marker: Marker3D = $HitchCheckMarker

var weapon_item_resource : WeaponItemResource

func _ready() -> void:
	hit_check_marker.position.z = -weapon_item_resource.range
	super()

func changing_energy() -> void:
	EventSystem.PLA_change_energy.emit(weapon_item_resource.energy_change_per_use)


func check_hit() -> void:
	var space_state := get_world_3d().direct_space_state
	var ray_query_params := PhysicsRayQueryParameters3D.new()
	ray_query_params.collide_with_areas = true
	# We want to hit the hitboxes which areas areas hence why bodies are false
	ray_query_params.collide_with_bodies = false
	ray_query_params.collision_mask = 8 # This is confusing but hear me out,
	# In project settings physics layer 3d we have layers in the hitbox its in layer 4
	# 'Layer 1' = 1 'Layer 2' = 2 'Layer 3 = 4' and 'Layer 4 = 8'
	ray_query_params.from = global_position
	ray_query_params.to = hit_check_marker.global_position
	
	var result := space_state.intersect_ray(ray_query_params)
	
	if not result.is_empty():
		result.collider.take_hit(weapon_item_resource)
