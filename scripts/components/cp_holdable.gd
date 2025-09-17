extends Component
class_name HoldableComponent

## Whether or not to lock to a grid when dropped
@export var grid_locked:bool = false

## The size of each grid cell
@export var grid_size:Vector2 = Vector2(16,16)
## The offset of the grid
@export var grid_offset:Vector2 = Vector2(0,0)

## A sprite2D to show where the actor will be placed
@export var placement_indicator:Sprite2D
## A AreaComponent to check if where the actor will
## be placed already has something there.
@export var placement_checker:AreaComponent

## Whether or not holding this actor stops it from being active
@export var makes_inactive:bool = true

@onready var original_z_index = actor.z_index

func _ready() -> void:
	if placement_indicator != null:
		placement_indicator.visible = grid_locked
	if placement_checker != null:
		placement_checker.actor = actor

var held:bool = false

func hold_by(holder:HolderComponent) -> bool:
	# Try to pick up/set down.
	held = holder.hold(actor)
	
	# If it was placed and it shouldn't have been
	# Pick it right back up again
	if held and placement_checker.has_overlapping_collisions():
		held = holder.hold(actor)
	
	
	# Handle making the actor inactive while held
	if makes_inactive:
		if held:
			actor.add_active_lock(self)
		else:
			actor.remove_active_lock(self)
	
	return held

func _process(delta: float) -> void:
	if not held and grid_locked: # If the placement failed their position should be locked to a grid
		# Round the actor's position to the grid
		actor.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
	
	# Raise the z_index by one while held
	actor.z_index = original_z_index + 1 if held else original_z_index
	
	# Position the placement_indicator and checker
	if placement_indicator != null and grid_locked:
		placement_indicator.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
	if placement_checker != null:
		if grid_locked:
			placement_checker.me.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
		else:
			placement_checker.me.global_position = actor.global_position
