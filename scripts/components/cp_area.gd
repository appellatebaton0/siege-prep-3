extends Component
class_name AreaComponent
var me:Area2D = get_me()

@onready var sub_components:Array[AreaSubComponent] = get_sub_components()
func get_sub_components() -> Array[AreaSubComponent]:
	var return_array:Array[AreaSubComponent]
	
	for child in get_children():
		if child is AreaSubComponent:
			return_array.append(child)
	
	return return_array

# Turn a integer layer into an array for easier working
# Note, the place in the array and the layer value
# in the editor are offset by one. Layer 1 = [0]
# Also, no layer 32 because that's terrifying
func get_layer_as_array(layer:int) -> Array[bool]:
	var return_array:Array[bool] = [
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false
		]
	
	var highest_value = 30;
	while layer > 0:
		if layer >= pow(2, highest_value):
			return_array[highest_value] = true
			layer -= pow(2, highest_value)
		highest_value -= 1
	
	return return_array
# Turn said array back into a collision layer
func get_array_as_layer(array:Array[bool]) -> int:
	var value:int = 0
	for i in range(len(array)):
		if array[i]:
			value += pow(2, i)
	return value

func layer_match(sub_component:AreaSubComponent, object:CollisionObject2D):

	var sub_comp_layers:Array[bool] = get_layer_as_array(sub_component.collision_layer)
	var obj_comp_mask:Array[bool] = get_layer_as_array(object.collision_mask)
	
	for i in range(len(sub_comp_layers)):
		if sub_comp_layers[i] and obj_comp_mask[i]:
			return true
	return false

func _on_area_entered(area:Area2D):
	var a = area
	if a is AreaComponent:
		if a.actor == actor:
			return
	# Run the area function for every valid subcomponent
	for component in sub_components:
		# Only do so if the component has a layer matching the area's
		if layer_match(component, area):
			component.on_area_entered(area)
	
func _on_body_entered(body:Node2D):
	# Run the body function for every valid subcomponent
	for component in sub_components:
		# Only do so if the component has a layer matching the body's
		if layer_match(component, body):
			component.on_area_entered(body)

var last_area_overlap:Array[Area2D]
var last_body_overlap:Array[Node2D]

func _process(delta: float) -> void:
	var areas:Array[Area2D] = me.get_overlapping_areas()
	
	# Get rid of ones by the same actor
	for area in areas:
		var a = area
		if a is AreaComponent:
			if a.actor == actor:
				areas.erase(area)
	
	# Run area-based while functions
	if len(areas) > 0:
		for component in sub_components:
			# If the overlap has changed,
			# Update the component's data
			if last_area_overlap != areas:
				var valid_areas:Array[Area2D]
				
				for area in areas:
					if layer_match(component, area):
						valid_areas.append(area)
				
				component.overlapping_areas = valid_areas
	
			# If it has overlapping areas, run accordingly
			if len(component.overlapping_areas) > 0:
				component.while_colliding_areas(component.overlapping_areas)
	
	var bodies:Array[Node2D] = me.get_overlapping_bodies()
	# Run body-based while functions
	if len(bodies) > 0:
		for component in sub_components:
			# If the overlap has changed,
			# Update the component's data
			if last_area_overlap != bodies:
				var valid_bodies:Array[Node2D]
				
				for body in bodies:
					if layer_match(component, body):
						valid_bodies.append(body)
				
				component.overlapping_bodies = valid_bodies
	
			# If it has overlapping areas, run accordingly
			if len(component.overlapping_bodies) > 0:
				component.while_colliding_bodies(component.overlapping_bodies)
	
	
	if last_area_overlap != areas:
		last_area_overlap = areas;
	if last_area_overlap != areas:
		last_area_overlap = areas;

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	for component in sub_components:
		component.on_input_event(viewport, event, shape_idx)
