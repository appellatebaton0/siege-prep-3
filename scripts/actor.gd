extends Node2D
class_name Actor

# A class for Node2Ds that allows them to adopt
# functionality from Components.

# See also: Interface for Controls -> Elements

@onready var components:Array[Component] = get_components()

func get_components() -> Array[Component]:
	var components:Array[Component]
	
	for child in get_children():
		if child is Component:
			components.append(child)
	
	return components
