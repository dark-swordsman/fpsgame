# CLASS INITIALIZATION

When initializing a class, `_init()` variables:
- need default values
    - Why: for example, with `.duplicate()`, it inits with defaults *then* copies values
- must be typed
    - Why: [STRICT_TYPING.md](STRICT_TYPING.md)
- must be prefixed with `p_`
    - Why: `self.variable = variable` causes a shadowing warning

Example:

```gdscript
func _init(
	p_item_name: String = "", 
	p_weight: int = 0, 
	p_grid_size: Vector2 = Vector2(0,0)
) -> void:
	item_name = p_item_name
	weight = p_weight
	grid_size = p_grid_size
```