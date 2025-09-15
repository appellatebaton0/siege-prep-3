extends Node2D
class_name Actor

func get_components() -> Array[Component]:
	var components:Array[Component]
	
	for child in get_children():
		if child is Component:
			components.append(child)
	
	return components
