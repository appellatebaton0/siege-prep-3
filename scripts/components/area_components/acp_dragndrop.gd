extends AreaSubComponent
class_name DragNDropComponent

var holding:bool = false
var hold_offset:Vector2

## How fast the actor follows the mouse, 0 = none, 1 = instant
@export_range(0.0, 1.0, 0.01) var follow_lerp:float = 0.5

## Whether or not to lock to a grid when dropped
@export var grid_locked:bool = false

## The size of each grid cell
@export var grid_size:Vector2 = Vector2(16,16)
## The offset of the grid
@export var grid_offset:Vector2 = Vector2(0,0)

func _process(delta: float) -> void:
	if holding:
		actor.global_position = lerp(actor.global_position, actor.get_global_mouse_position() + hold_offset, follow_lerp)

func on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		holding = event.is_pressed()
		
		hold_offset = actor.global_position - actor.get_global_mouse_position()
		
		if holding == false and grid_locked:
			actor.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
