extends AreaSubComponent
class_name HitboxComponent
var me:Area2D = get_me()

signal did_damage
signal clicked_on

func hurt(hurtee:Actor):
	did_damage.emit()

func on_area_entered(area: Area2D) -> void:
	var component = area # Abstract type
	if component is HurtboxComponent:
		hurt(component.actor)

func on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			clicked_on.emit()
