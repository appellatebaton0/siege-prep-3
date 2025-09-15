extends Component
class_name AreaSubComponent

@export_flags_2d_physics var collision_layer
var area_component:AreaComponent = get_parent()

func on_area_entered(area:Area2D):
	pass
func on_body_entered(body:Node2D):
	pass

func while_colliding_areas(areas:Array[Area2D]):
	pass
func while_colliding_bodies(bodies:Array[Node2D]):
	pass

func on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass
