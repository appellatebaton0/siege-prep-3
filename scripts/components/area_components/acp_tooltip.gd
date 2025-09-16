extends AreaSubComponent
class_name TooltipAreaSubComponent
var me:Control = get_me()

@export var fade_speed:float = 10.0

@export var fade_in_delay:float = 0.4
var fade_in_timer:float = 0.0

func while_any_collisions(delta:float):
	if not area_component.function_disabled():
		me.global_position = me.get_global_mouse_position()
		me.rotation = -actor.rotation
		
		fade_in_timer = move_toward(fade_in_timer, 0, delta)
		if fade_in_timer <= 0:
			me.modulate.a = move_toward(me.modulate.a, 1, delta * fade_speed)
	else:
		fade_in_timer = fade_in_delay
		me.modulate.a = move_toward(me.modulate.a, 0, delta * fade_speed)

func while_no_collisions(delta: float) -> void:
	fade_in_timer = fade_in_delay
	me.modulate.a = move_toward(me.modulate.a, 0, delta * fade_speed)
