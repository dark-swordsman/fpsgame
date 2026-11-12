class_name WorldItem extends Node3D

var item: Item

func _init(
	p_item: Item = null
) -> void:
	item = p_item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
