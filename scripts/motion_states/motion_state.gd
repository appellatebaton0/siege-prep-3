extends Node
class_name MotionState

@onready var component:MotionComponent = get_parent()
@onready var character:CharacterBody2D = component.me

## Helper functions
func vec2_move_towards(a:Vector2, b:Vector2, delta:float):
	a.x = move_toward(a.x, b.x, delta)
	a.y = move_toward(a.y, b.y, delta)
	
	return a

## Ran functions

# Active
func phys_active(_delta:float):
	pass
func active(_delta:float):
	pass

# Inactive
func phys_inactive(_delta:float):
	pass
func inactive(_delta:float):
	pass

# On change
func on_active():
	pass
func on_inactive():
	pass
