extends PlayerMenuBase

@onready var crafting_button_container: GridContainer = %CraftingButtonContainer

@export var crafting_button_scene : PackedScene



func _ready() -> void:
	for craftable_item_key in ItemConfig.ITEM_CRAFTABLE_KEYS:
		var crafting_button := crafting_button_scene.instantiate() 
		crafting_button_container.add_child(crafting_button)
		crafting_button.set_item_key(craftable_item_key)
		crafting_button.button.mouse_entered.connect(show_crafting_info.bind(crafting_button.item_key))
		crafting_button.button.mouse_exited.connect(hide_crafting_info)
		crafting_button.button.pressed.connect(crafting_button_pressed.bind(crafting_button.item_key))
	
	super()

func update_inventory(inventory : Array) -> void:
	#Super executes what is in the parent classes
	super(inventory)
	update_craft_button_disables(inventory)

func update_craft_button_disables(inventory:Array) -> void:
	for crafting_button in crafting_button_container.get_children():
		var crafting_blueprint := ItemConfig.get_crafting_blueprint_resource(crafting_button.item_key)
		var disable_button := false 
		
		if crafting_blueprint.needs_multitool and not ItemConfig.Keys.Multitool in inventory:
			disable_button = true
		
		elif crafting_blueprint.needs_tinderbox and not ItemConfig.Keys.Tinderbox in inventory:
			disable_button = true
		
		else:
			for cost_data in crafting_blueprint.cost:
				if inventory.count(cost_data.item_key) < cost_data.amount:
					disable_button = true
					break
		
		
		crafting_button.button.disabled = disable_button



func show_crafting_info(item_key:ItemConfig.Keys) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	var item_resource := ItemConfig.get_item_resource(item_key)
	item_info_label.text = item_resource.display_name + "\n" + item_resource.description
	extra_info_label.text = "Requirements:"
	
	var blueprint := ItemConfig.get_crafting_blueprint_resource(item_key)
	for cost_resource in blueprint.cost:
		var cost_item_name := ItemConfig.get_item_resource(cost_resource.item_key).display_name
		extra_info_label.text += "\n%s: %d" % [cost_item_name, cost_resource.amount]
	
	if blueprint.needs_multitool:
		extra_info_label.text += "\nMultitool"
	
	if blueprint.needs_tinderbox:
		extra_info_label.text += "\nTinderbox"


#func show_crafting_info(item_key : ItemConfig.Keys) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or item_key == null:
		#return
	#
	#var item_resource := ItemConfig.get_item_resource(item_key)
	#
	#item_description_label.text =item_resource.display_name + "\n" + item_resource.description
	#
	#item_extra_info_label.text = "Requirements: "
	#
	#var blueprints := ItemConfig.get_crafting_blueprint_resource(item_key)
	#
	#if blueprints.needs_multitool:
		#item_extra_info_label.text += "\nMultitool"
	#
	#if blueprints.needs_tinderbox:
		#item_extra_info_label.text += "\nTinderbox"
	#
	#for cost_resource in blueprints.amount:
		##var cost_item_name = ItemConfig.get_item_resource(cost_resource.item_key).display_name
		#item_extra_info_label.text += "\n%s: %d" % [
			#ItemConfig.get_item_resource(cost_resource.item_key).display_name,
			#cost_resource.amount
		#]


func hide_crafting_info() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	item_info_label.text = ""
	extra_info_label.text = ""




func crafting_button_pressed(item_key : ItemConfig.Keys) -> void:
	EventSystem.INV_delete_crafting_blueprint_cost.emit(ItemConfig.get_crafting_blueprint_resource(item_key).cost)
	EventSystem.INV_add_item.emit(item_key)
