extends Control
class_name Interface

# A class for Controls that allows them to adopt
# functionality from Elements.

# See also: Actor for Node2Ds -> Components

@onready var elements:Array[Element] = get_elements()

func get_elements(depth:int = 4, with:Node = self) -> Array[Element]:
	if depth <= 0:
		return []
	
	var elements:Array[Element]
	
	for child in with.get_children():
		if child is Element:
			elements.append(child)
		
		elements.append_array(get_elements(depth - 1, child))
	
	return elements
