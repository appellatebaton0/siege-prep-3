extends Node
class_name Component

## The actor the component belongs to
@onready var actor:Actor = find_actor()
func find_actor() -> Actor:
	var parent = get_parent()
	var grand = parent.get_parent()
	
	if parent is Actor:
		return parent
	elif grand is Actor:
		return grand
	
	return null

## Get the self as a Variant, for typecasting that
## bypasses faulty Intelli-sense
func get_me():
	return self
