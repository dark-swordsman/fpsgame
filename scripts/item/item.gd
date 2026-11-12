class_name Item extends Resource

var name: String
var weight: int # grams
var description: String
var volume: int # arbitrary for now
var grid_size: Vector2 # inventory grid size; im unsure if this needs to be moved later

func _init(
	p_name: String = "", 
	p_description: String = "",
	p_weight: int = 0,
	p_volume: int = 0,
	p_grid_size: Vector2 = Vector2(0,0),
) -> void:
	name = p_name
	description = p_description
	weight = p_weight
	volume = p_volume
	grid_size = p_grid_size

# Item
# - always exists as a data structure first and foremost
# - has weight (int, fixed to 3 decimals in display, could just be kg (so 0.001 is 1g))
# - has grid size
# - can be picked up (not part of Item, but part of the 3D representation of the Object)
# - may have other properties that are currently unknown
# - may have functions based on context, which could be loaded as a definition
#   - akin to how Godot PlayerCharacter extends Node3D
#   - so for example: when a gun extends Item, it inherits "pickup" 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
