extends Element
class_name TextureRectElement


@export var source:Element
@export var value:String
var me:TextureRect = get_me()

func _update_texture():
	
	# Split the value into subvalues for every "."
	# So you can get subvalues >:D
	var sub_values:Array[String]
	var real_value:String = value
	while true:
		var find_value:int = real_value.find(".")
		if find_value != -1:
			sub_values.append(real_value.left(find_value))
			real_value = real_value.erase(0, find_value + 1)
		else:
			sub_values.append(real_value)
			break
	
	# Travel down the subvalue list to get the value
	var this_value
	while len(sub_values) > 0:
		if this_value == null:
			this_value = source.get(sub_values[0])
			sub_values.pop_front()
		else:
			this_value = this_value.get(sub_values[0])
			sub_values.pop_front()

	me.texture = this_value
