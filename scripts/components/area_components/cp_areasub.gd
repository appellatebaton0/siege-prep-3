extends Component
class_name AreaSubComponent
func _init() -> void:
	component_id = "AreaSub"

@export_flags_2d_physics var collision_mask
@onready var area_component:AreaComponent = get_parent()

# Upkept by the AreaComponent, note objects overlapping with this one. 
var overlapping_areas:Array[Area2D]
var overlapping_bodies:Array[Node2D]

func get_collisions() -> Array[Node2D]:
	var collisions = overlapping_bodies.duplicate()
	collisions.append_array(overlapping_areas.duplicate())
	return collisions

func has_collisions():
	return len(overlapping_areas) > 0 or len(overlapping_bodies) > 0

func on_area_entered(area:Area2D) -> void:
	pass
func on_body_entered(body:Node2D) -> void:
	pass

func while_colliding_areas(areas:Array[Area2D], delta:float) -> void:
	pass
func while_colliding_bodies(bodies:Array[Node2D], delta:float) -> void:
	pass

func while_no_colliding_areas(delta:float) -> void:
	pass
func while_no_colliding_bodies(delta:float) -> void:
	pass

func while_no_collisions(delta:float) -> void:
	pass
func while_any_collisions(delta:float) -> void:
	pass


func on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass
