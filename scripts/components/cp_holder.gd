extends Component
class_name HolderComponent
var me:Node2D = get_me()

var holding:Actor = null
var hold_offset:Vector2 = Vector2.ZERO

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
		hold_offset = target.global_position - me.get_global_mouse_position()
		return true # Respond that it was picked up

func _process(delta: float) -> void:
	if holding != null:
		holding.global_position = me.global_position + hold_offset
