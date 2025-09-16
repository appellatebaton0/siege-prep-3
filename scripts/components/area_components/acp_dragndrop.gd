extends AreaSubComponent
class_name DragNDropAreaSubComponent
@onready var me:Node = get_me()

var holding:bool = false
var hold_offset:Vector2

## A sprite2D to show where the actor will be placed
@export var placement_indicator:Sprite2D
## A AreaComponent to check if where the actor will
## be placed already has something there.
@export var placement_checker:AreaComponent
# Where to set the actor down. If the placement checker
# doesn't suceed, this holds the pick-up position 
var set_down_position:Vector2

## Whether or not holding this actor stops it from functioning
@export var disables_function:bool = true

## How fast the actor follows the mouse, 0 = none, 1 = instant
@export_range(0.0, 1.0, 0.01) var follow_lerp:float = 0.5

## Whether or not to lock to a grid when dropped
@export var grid_locked:bool = false

## The size of each grid cell
@export var grid_size:Vector2 = Vector2(16,16)
## The offset of the grid
@export var grid_offset:Vector2 = Vector2(0,0)

@onready var original_z_index = actor.z_index

func _ready() -> void:
	if placement_indicator != null:
		placement_indicator.visible = grid_locked
	if placement_checker != null:
		placement_checker.actor = actor

func _process(delta: float) -> void:
	actor.z_index = original_z_index + 1 if holding else original_z_index
	
	if placement_indicator != null and grid_locked:
		placement_indicator.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
	if placement_checker != null:
		if grid_locked:
			placement_checker.me.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
		else:
			placement_checker.me.global_position = actor.global_position
	
	if holding:
		if disables_function:
			area_component.add_function_disabler(me)
		
		actor.global_position = lerp(actor.global_position, actor.get_global_mouse_position() + hold_offset, follow_lerp)
	else:
		if disables_function:
			area_component.remove_function_disabler(me)
		
		if grid_locked:
			actor.global_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset



func while_no_colliding_bodies(_delta:float) -> void:
	holding = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		holding = event.is_pressed()
		
		if holding:
			## SFX: play pickup sound
			set_down_position = actor.global_position
		elif placement_checker != null:
			if not placement_checker.has_overlapping_collisions():
				## SFX: play position fail
				set_down_position = actor.global_position
			else:
				## SFX: play position suceed / place
				pass
			actor.global_position = set_down_position
		
		hold_offset = actor.global_position - actor.get_global_mouse_position()
