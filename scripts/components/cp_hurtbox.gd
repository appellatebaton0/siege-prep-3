extends Component
class_name HurtboxComponent
var me:Area2D = get_me()

signal got_hurt
signal clicked_on

func hurt(hurter:Actor):
	got_hurt.emit()


func _on_area_entered(area: Area2D) -> void:
	print(area)
	var component = area # Abstract type
	if component is HitboxComponent:
		hurt(component.actor)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			clicked_on.emit()
