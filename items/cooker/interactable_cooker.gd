extends Interactable
class_name InteractableCooker


@onready var cooking_timer: Timer = $CookingTimer
@onready var food_visual_holder: Marker3D = $FoodVisualHolder
@onready var fire_particles: GPUParticles3D = $GPUParticles3D
@onready var fire_light: OmniLight3D = $OmniLight3D

#This is somewhat optional we added a ready function and turn off omnilight3d 
# as shown on the right and turned off the "emitting"
@export var fire_always_on := true

var cooking_recipe : CookingRecipeResource

enum CookingStates {
	Inactive,
	ReadyToCook,
	Cooking,
	Cooked
}

var state := CookingStates.Inactive

func _ready() -> void:
	if fire_always_on:
		fire_particles.emitting = true
		fire_light.show()


func start_interaction() -> void:
	EventSystem.BUL_create_bulletin.emit(
		BulletinConfig.Keys.CookingMenu,
		[
			cooking_recipe,
			0.0 if state != CookingStates.Cooking or not cooking_recipe else (cooking_recipe.cooking_time - cooking_timer.time_left),
			self,
			state
		]
	)

func uncooked_item_added(recipe : CookingRecipeResource) -> void:
	state = CookingStates.ReadyToCook
	cooking_recipe = recipe
	food_visual_holder.add_child(cooking_recipe.uncooked_item_visuals.instantiate())
	

func uncooked_item_removed() -> void:
	state = CookingStates.Inactive
	cooking_recipe = null
	clear_food_visuals()


func cooked_item_removed() -> void:
	state = CookingStates.Inactive
	cooking_recipe = null
	clear_food_visuals()


func clear_food_visuals() -> void:
	for child in food_visual_holder.get_children():
		child.queue_free()


func start_cooking() -> void:
	state = CookingStates.Cooking
	cooking_timer.start(cooking_recipe.cooking_time)
	
	if not fire_always_on:
		fire_particles.emitting = true
		fire_light.show()


func cooking_finished() -> void:
	state = CookingStates.Cooked
	clear_food_visuals()
	
	if not fire_always_on:
		fire_particles.emitting = false
		fire_light.hide()
	
	food_visual_holder.add_child(cooking_recipe.cooked_item_visuals.instantiate())

