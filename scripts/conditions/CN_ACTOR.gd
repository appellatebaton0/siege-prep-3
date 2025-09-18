extends Condition
class_name COMPONENTCondition

# Pull a bool value from a commponent using its actor and id

## The path to the actor to pull from.
@export var actor_path:NodePath
var actor:Actor
## The component_id (name of the component's class - Component, ie Area)
@export var component_id:String
var component:Component

## The path to a value in the component. Hopefully a bool. 
## Also works for checking if a node exists. (ie, "actor" or "actor.condition.component_id")
## Leave blank to get whether an actor has a component with component_id
@export var bool_path:String

func valid() -> bool:
	if actor == null or component == null:
		return false # Something went wrong with initialization, or the component didn't exist
	
	# Find the component that the id of was given
	var found:bool = false 
	for ac_component in actor.get_components():
		if ac_component.component_id == component_id:
			component = ac_component
			found = true
	
	# If no bool path, just return if the component was found 
	if bool_path == "":
		return found
	
	
	# Split the value into subvalues for every "."
	# So you can get subvalues >:D
	var sub_values:Array[String]
	var real_path:String = bool_path
	while true:
		var find_value:int = real_path.find(".")
		if find_value != -1:
			sub_values.append(real_path.left(find_value))
			real_path = real_path.erase(0, find_value + 1)
		else:
			sub_values.append(real_path)
			break
	
	# Travel down the subvalue list to get the value
	var this_value
	while len(sub_values) > 0:
		if this_value == null:
			this_value = component.get(sub_values[0])
			sub_values.pop_front()
		else:
			this_value = this_value.get(sub_values[0])
			sub_values.pop_front()
	
	# If it's a thing and exists, true
	if this_value is Node or this_value is Resource:
		return true
	# If it doesn't exist, false
	elif this_value == null:
		return false
	# If it's a bool, return it.
	elif this_value is bool:
		return this_value
	return false

func initialize(with:Node):
	actor = with.get_node(actor_path)
	
	
