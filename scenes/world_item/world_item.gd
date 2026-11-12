class_name WorldItem extends Node3D

var item: Item
var cube: PackedScene = preload("res://scenes/objects/basic_cube/basic_cube.tscn")

enum InitState { SUCCESS, FAIL }

func _init(
	p_item: Item = null
) -> void:
	# null may break, that's ok for now
	item = p_item
	self.name = "%s-%s" % [p_item.name, p_item.id]
	self.add_child(cube.instantiate())
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_spawn_pos: Vector3 = Globals.in_front_of_player(Vector3(1,1,1))
	self.position = player_spawn_pos
	self.get_child(0).apply_impulse((player_spawn_pos - Globals.player.position) * Vector3(2,0,2))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
