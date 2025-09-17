extends AreaSubComponent
class_name ConveyorAreaSubComponent

@export var convey_amount:Vector2 = Vector2(1, 0)
var motion_components:Array[MotionComponent] = []

func convey(target:Actor, motion:MotionComponent = null):
	
	if area_component.function_disabled():
		return
	
	if motion == null:
		for component in target.get_components():
			if component is MotionComponent:
				motion = component
	
	
	if motion.overrider == null:
		if not motion_components.has(motion):
			motion_components.append(motion)
		
		motion.overrider = self
		motion.me.velocity = convey_amount.rotated(actor.rotation)

func _process(delta: float) -> void:
	# Undo the override
	for component in motion_components:
		# IF the motioncomponent isn't overlapping anymore
		if not overlapping_areas.has(component) and not overlapping_bodies.has(component):
			component.overrider = null
			motion_components.erase(component)
			component = null

func while_colliding_areas(areas:Array[Area2D], delta:float) -> void:
	for area in areas:
		var a = area
		if a is Component:
			convey(a.actor)
func while_colliding_bodies(bodies:Array[Node2D], delta:float) -> void:
	for body in bodies:
		var b = body
		if b is Component:
			# Take a shortcut if this already IS
			# the MotionComponent
			if b is MotionComponent:
				convey(b.actor, b)
			convey(b.actor)
