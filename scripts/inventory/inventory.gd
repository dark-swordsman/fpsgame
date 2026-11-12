class_name Inventory extends Resource
# Inventory
# - almost always will belong to a physical thing in the world
#   - this includes items
# - can hold items
# - can belong to a player or object (container)

var items: Array[Item]
var max_weight: int # in grams
var max_volume: int # arbitrary unit for now

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
