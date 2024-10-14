extends Resource
class_name CraftingBluePrintResource

@export var item_key := ItemConfig.Keys.Axe
@export var cost : Array [BluePrintCostData] = []
@export var needs_multitool := false
@export var needs_tinderbox := false  
