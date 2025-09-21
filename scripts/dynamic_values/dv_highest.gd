extends DynamicValue
class_name HighestDynamicValue

@export var highvalue:DynamicValue

var high = 0

func _process(_delta: float) -> void:
	high = max(high, highvalue.value())

func value():
	return high
