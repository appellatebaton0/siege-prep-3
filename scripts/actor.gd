extends Node2D
class_name Actor

# A class for Node2Ds that allows them to adopt
# functionality from Components.

# See also: Interface for Controls -> Elements

var active_lockers:Array[Node]
func add_active_lock(node:Node) -> bool:
	if not active_lockers.has(node):
		active_lockers.append(node)
		return true
	return false
func remove_active_lock(node:Node) -> bool:
	if active_lockers.has(node):
		active_lockers.erase(node)
		return true
	return false
func is_active() -> bool:
	return len(active_lockers) == 0

@onready var components:Array[Component] = get_components()

func get_components() -> Array[Component]:
	var components:Array[Component]
	
	for child in get_children():
		if child is Component:
			components.append(child)
	
	return components
