# CLASS INITIALIZATION

When initializing a class, `_init()` variables:
- need default values
    - Why: for example, with `.duplicate()`, it inits with defaults *then* copies values
    - Object-typed parameters (e.g. `Item`, `Resource`) should default to `null` wherever possible
        - Why: a default like `Item.new()` creates a blank object that looks real; `null` makes "nothing passed" explicit
        - Note: only object types can be `null`; built-in types (`int`, `String`, `Vector2`, etc.) still need a real default
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