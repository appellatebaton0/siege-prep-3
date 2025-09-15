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

func _ready() -> void:
	print(sub_components)
	print(if_layer_match(sub_components[0],me))

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
	
func if_layer_match(sub_component:AreaSubComponent, object:CollisionObject2D):

	var sub_comp_layers:Array[bool] = get_layer_as_array(sub_component.collision_layer)
	var obj_comp_mask:Array[bool] = get_layer_as_array(object.collision_mask)
	
	print(sub_comp_layers)
	print(obj_comp_mask)
	
	for i in range(len(sub_comp_layers)):
		print("comparing ", i)
		if sub_comp_layers[i] and obj_comp_mask[i]:
			print("true")
			return true
		print("false")
	return false
	

func _on_area_entered(area:Area2D):
	# Run the function for every subcomponent
	for component in sub_components:
		# NOTE: Make a layer match here.
		if true:
			component.on_area_entered(area)
	
func _on_body_entered():
	pass

func _process(delta: float) -> void:
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
