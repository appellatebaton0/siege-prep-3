extends Component
class_name HoldableComponent

# Not much else to say... actually, let's move the grid here.


## Whether or not to lock to a grid when dropped
@export var grid_locked:bool = false

## The size of each grid cell
@export var grid_size:Vector2 = Vector2(16,16)
## The offset of the grid
@export var grid_offset:Vector2 = Vector2(0,0)

var held:bool = false

func hold_by(holder:HolderComponent) -> bool:
	var hold_attempt:bool = holder.hold(actor)
	
	held = hold_attempt
	
	return hold_attempt

func _process(delta: float) -> void:
	if not held and grid_locked: # If the placement failed and gridlocked
		# Set the actor's position to a round
		actor.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
