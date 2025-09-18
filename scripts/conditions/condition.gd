extends Resource
class_name Condition

func valid() -> bool:
	return true

# Needs to be initialized by its user, so it can
# get access to the tree.
func initialize(with:Node):
	pass
