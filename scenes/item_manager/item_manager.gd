class_name ItemManager extends Node

var item_store: ItemStore

func _init() -> void:
	item_store = ItemStore.new()
	
func _ready() -> void:
	DebugOverlay.register("Item Store Count", func() -> int: return item_store.get_count())
	
func _physics_process(delta: float) -> void:
	#benchmark()
	pass
	
func benchmark() -> void:
	for i: int in range(randi() % 100):
		item_store.create_item({
			"id": "",
			"name": "hotdog",
			"description": "a warm glizzy",
			"weight": 1000,
			"volume": 1000,
			"grid_size": Vector2(1,5)
		})
