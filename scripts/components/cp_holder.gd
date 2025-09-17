extends Component
class_name HolderComponent
var me:Node2D = get_me()

var holding:Actor = null

# Picking up and putting down
# Returns whether or not target was picked up
func hold(target:Actor) -> bool:
	if holding != null: # Already holding something
		if target == holding: # Trying to put it down
			holding = null
			return false # Respond that it was put down
		else: # Trying to pick up a second thing
			return false # Respond that it wasn't picked up
	else: # Not holding anything
		holding = target
		return true # Respond that it was picked up

func _process(delta: float) -> void:
	holding.global_position = me.global_position
