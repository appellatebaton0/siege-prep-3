extends Element
class_name InvSlotButtonElement

signal amount_changed(to:int)
signal holding_changed(to:Actor)

## Define an initially held Actor
@export var initial_holding:PackedScene
var holding:Actor
## How many of the actor is held
@export var amount:int = 0
@export var max_amount:int = 1

## Defaults to this element's parent.
@export var button:EM_Button
var button_element:EM_Button

## The place newly added objects should go
@export var main:Node

## The actor that represents the mouse
@export var mouse_actor:Actor
var mouse_holder:HolderComponent
## Alternatively, use this to use the first node in a node group
@export var mouse_group_name:String 

## If an actor has the necessary component to get into this slot
func check_actor_validity(actor:Actor) -> bool:
	for component in actor.get_components():
		if component is SlotableComponent:
			return true
	return false
## Get a valid actor's slotablecomponent
func get_actor_slotable(actor:Actor) -> SlotableComponent:
	for component in actor.get_components():
		if component is SlotableComponent:
			return component
	return null
## If an actor is of the same type
func check_actor_match(actor:Actor) -> bool:
	if not check_actor_validity(actor) or holding == null:
		return false
	return get_actor_slotable(actor).id == get_actor_slotable(holding).id

func _ready() -> void:
	# Set the button element
	button_element = button if button != null else (get_parent() if get_parent() is EM_Button else null)
	button_element.me.pressed.connect(_on_pressed)
	
	# Mouse group -> mouse_actor setup
	if mouse_actor == null and mouse_group_name != null:
		var mouse = get_tree().get_first_node_in_group(mouse_group_name)
		
		if mouse is Actor:
			mouse_actor = mouse
	# Mouse Holder setup
	for component in mouse_actor.get_components():
		if component is HolderComponent:
			mouse_holder = component
	
	## Setting an initial holding.
	if initial_holding != null:
		var initial_hold:Actor = initial_holding.instantiate()
		if check_actor_validity(initial_hold):
			# Modify it accordingly
			main.add_child(initial_hold)
			initial_hold.add_active_lock(self)
			initial_hold.hide()
			
			holding = initial_hold
		else:
			initial_hold.queue_free()

func _on_pressed():
	# Trying to put something in an empty slot
	if amount == 0 and mouse_holder.holding != null:
		# Take the actor from the mouse
		holding = mouse_holder.holding
		mouse_holder.holding = null
		amount += 1
		
		# Modify it accordingly
		holding.add_active_lock(self)
		holding.hide()
	# Trying to put something in a occupied slot
	elif amount > 0 and mouse_holder.holding != null and check_actor_match(mouse_holder.holding) and amount < max_amount:
		# Free it from this mortal coil
		mouse_holder.holding.queue_free()
		
		# Take the actor from the mouse
		mouse_holder.holding = null
		amount += 1
	# Trying to take something from an occupied slot
	elif amount > 0 and mouse_holder.holding == null:
		print(amount)
		# Give an actor to the mouse
		if amount > 1:
			# Make a new one
			var new = holding.duplicate()
			
			# Modify it accordingly
			new.remove_active_lock(self)
			new.show()
			main.add_child(new)
			
			# Give it to the mouse
			mouse_holder.holding = new
			amount -= 1
		else: # Only got one :(
			# Modify it accordingly
			holding.remove_active_lock(self)
			holding.show()
			
			if holding.get_parent() == null:
				main.add_child(holding)
			
			# Give it to the mouse
			mouse_holder.holding = holding
			holding = null
			amount -= 1
