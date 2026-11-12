extends Control
## Custom DebugOverlay for checking values
##
## Use DebugOverlay.register() to register

# Possible cool future features:
# - presets for data types
#   - for example: a "mouse_input" type that pre-fills mouse data

var registeredInputs: Dictionary[String,DebugInput] = {}

enum RegistrationStatus {SUCCESS_REGISTERED, SUCCESS_UNREGISTERED, FAIL_ALREADY_REGISTERED}

class DebugInput:
	var _name: String
	var valueRef: Callable
	var labelRef: Callable
	
	func _init(__name: String, _valueRef: Callable, label: Callable) -> void:
		_name = __name
		valueRef = _valueRef
		labelRef = label
		
	func update() -> void:
		# update the actual label
		var label: Label = labelRef.call()
		label.text = DebugOverlay.labelFormatter(_name, valueRef.call())
	
func register(_name: String, value: Variant) -> RegistrationStatus:
	# check if the name exists
	if registeredInputs.get(_name):
		return RegistrationStatus.FAIL_ALREADY_REGISTERED
	else:
		var label: Label = addLabel(_name, value)
		var debugInput: DebugInput = DebugInput.new(_name, value, func() -> Label: return label)
		registeredInputs.set(_name, debugInput)
		return RegistrationStatus.SUCCESS_REGISTERED
		
func unregister(_name: String) -> RegistrationStatus:
	removeLabel(registeredInputs[name].labelRef.call())
	registeredInputs.erase(name)
	return RegistrationStatus.SUCCESS_UNREGISTERED
	
func addLabel(_name: String, value: Variant) -> Label:
	var label: Label = Label.new();
	label.text = labelFormatter(_name, value)
	label.name = _name
	$DebugLabelContainer.add_child(label)
	return label

func removeLabel(label: Label) -> void:
	$DebugLabelContainer.remove_child(label)
	
func labelFormatter(_name: String, value: Variant) -> String:
	return "%s: %s" % [_name, value]	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	for debugInput in registeredInputs:
		registeredInputs[debugInput].update()
