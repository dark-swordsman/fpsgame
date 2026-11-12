class_name Inventory extends Resource

var items: Array[InventoryItem]
var max_weight: int # in grams
var max_volume: int # arbitrary unit for now

class InventoryItem:
	# representation of the item in the inventory
	var grid_position: Vector2i
	var item: Item
	
	func _init(p_grid_position: Vector2i = Vector2i(0,0), p_item: Item = null) -> void:
		grid_position = p_grid_position
		item = p_item
	

func _init(
	p_items: Array[InventoryItem] = [],
	p_max_weight: int = 0,
	p_max_volume: int = 0,
) -> void:
	items = p_items
	max_weight = p_max_weight
	max_volume = p_max_volume

# Inventory
# - almost always will belong to a physical thing in the world
#   - this includes items
# - can hold items
# - can belong to a player or object (container)

func addItem(item: Item) -> void:
	pass
	
func removeItem(item: Item) -> void:
	pass

func getItems() -> Array[Item]:
	return items




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
