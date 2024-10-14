class_name ItemConfig

# When you print inventory you get a numerical representation
# Stick = 0, Stone =  1, Plant = 2

enum Keys {
	
	#Pickupabble
	Stick,
	Stone,
	Plant,
	Mushroom,
	Fruit,
	Log,
	Coal,
	FlintStone,
	RawMeat,
	CookedMeat,
	
	#Craftable
	Axe,
	Pickaxe,
	Campfire,
	Multitool,
	Rope,
	Tinderbox,
	Torch,
	Tent,
	Raft
	
}

const ITEM_CRAFTABLE_KEYS : Array[Keys] = [
	Keys.Axe,
	Keys.Pickaxe,
	Keys.Campfire,
	Keys.Multitool,
	Keys.Rope,
	Keys.Tinderbox,
	Keys.Torch,
	Keys.Tent,
	Keys.Raft
]


const ITEM_RESOURCE_PATH ={
	Keys.Stick : "res://resources/item_resources/stick_resource.tres",
	Keys.Stone : "res://resources/item_resources/stone_resource.tres",
	Keys.Plant : "res://resources/item_resources/plant_resource.tres",
	Keys.Mushroom : "res://resources/item_resources/mushroom_resource.tres",
	Keys.Fruit : "res://resources/item_resources/fruit_resource.tres",
	
	Keys.Pickaxe : "res://resources/item_resources/pickaxe_resource.tres",
	Keys.Axe : "res://resources/item_resources/axe_resource.tres",
	Keys.Rope : "res://resources/item_resources/rope_resource.tres",
	Keys.Torch : "res://resources/item_resources/torch_resource.tres",
	
	Keys.Coal : "res://resources/item_resources/coal_resource.tres",
	Keys.FlintStone : "res://resources/item_resources/flint_resource.tres",
	Keys.RawMeat : "res://resources/item_resources/raw_meat_resource.tres",
	Keys.Log : "res://resources/item_resources/log_resource.tres",
	
	Keys.Tent : "res://resources/item_resources/tent_resource.tres",
	Keys.Campfire : "res://resources/item_resources/campfire_resource.tres",
	Keys.Multitool : "res://resources/item_resources/multitool_resource.tres",
	Keys.Tinderbox : "res://resources/item_resources/tinderbox_resource.tres",
	Keys.Raft : "res://resources/item_resources/raft_resource.tres",
	
	Keys.CookedMeat : "res://resources/item_resources/cooked_meat.tres"
} 

static func get_item_resource(item_key : Keys) -> ItemResource:
	return load(ITEM_RESOURCE_PATH.get(item_key))


const CRAFTING_BLUEPRINT_RESOURCE_PATH ={
	Keys.Axe : "res://resources/crafting_blueprint_resources/axe_blueprint.tres",
	Keys.Rope : "res://resources/crafting_blueprint_resources/rope_blueprint.tres",
	Keys.Pickaxe : "res://resources/crafting_blueprint_resources/pickaxe_blueprint.tres",
	Keys.Campfire : "res://resources/crafting_blueprint_resources/campfire_blueprint.tres",
	Keys.Multitool : "res://resources/crafting_blueprint_resources/multitool_blueprint.tres",
	Keys.Raft : "res://resources/crafting_blueprint_resources/raft_blueprint.tres",
	Keys.Tent : "res://resources/crafting_blueprint_resources/tent_blueprint.tres",
	Keys.Tinderbox : "res://resources/crafting_blueprint_resources/tinderbox_blueprint.tres",
	Keys.Torch : "res://resources/crafting_blueprint_resources/torch_blueprint.tres"
	
}

static func get_crafting_blueprint_resource(item_key : Keys) -> CraftingBluePrintResource:
	return load(CRAFTING_BLUEPRINT_RESOURCE_PATH.get(item_key))

const EQUIPPABLE_ITEM_PATH ={
	Keys.Axe : "res://items/equippables/equippable_axe.tscn",
	Keys.Mushroom : "res://items/equippables/equippable_mushroom.tscn",
	Keys.Pickaxe : "res://items/equippables/equippable_pickaxe.tscn",
	Keys.Tent : "res://items/equippables/equippable_tent.tscn",
	Keys.Campfire : "res://items/equippables/equippable_campfire.tscn",
	Keys.CookedMeat : "res://items/equippables/equippable_cooked_meat.tscn",
	Keys.Fruit : "res://items/equippables/equippable_fruit.tscn",
	Keys.Raft : "res://items/equippables/equippable_raft.tscn",
	Keys.Torch : "res://items/equippables/equippable_torch.tscn"
}
static func get_equippable_item(item_key : Keys) -> PackedScene:
	return load(EQUIPPABLE_ITEM_PATH.get(item_key))

#This is when we want an obect to spawn when we hit something
const PICKUPPABLE_ITEM_PATH ={
	Keys.Log : "res://items/interactables/rigid_pickupable_log.tscn",
	Keys.Coal : "res://items/interactables/rigid_pickupable_coal.tscn",
	Keys.FlintStone : "res://items/interactables/rigid_pickupable_flintstone.tscn",
	Keys.RawMeat : "res://items/interactables/rigid_pickupable_raw_meat.tscn"
}
static func get_pickuppble_item(item_key : Keys) -> PackedScene:
	return load(PICKUPPABLE_ITEM_PATH.get(item_key))


const CONSTRUCTABLE_SCENES_PATH ={
	Keys.Tent : "res://objects/constructable/constructable_tent.tscn",
	Keys.Campfire : "res://objects/constructable/constructable_campfire.tscn",
	Keys.Raft : "res://objects/constructable/constructable_raft.tscn"
}

static func get_constructable_scene(item_key : Keys) -> PackedScene:
	return load(CONSTRUCTABLE_SCENES_PATH.get(item_key))
