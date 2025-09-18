extends Element
class_name EM_Label

@export var source:Element
@export var values:Array[String]
var me:Label = get_me()

## Use {x} to substitue values, with x being the index in the values array.
@export var text_format:String = "{0}"

func _ready() -> void:
	_update_label()

func _update_label():
	var real_values:Array[Variant]
	for value in values:
		
		# Split the value into subvalues for every "."
		# So you can get subvalues >:D
		var sub_values:Array[String]
		while len(value) > 0:
			var find_value:int = value.find(".")
			if find_value != -1:
				sub_values.append(value.left(find_value))
				value = value.erase(0, find_value + 1)
			else:
				sub_values.append(value)
				value = ""
		
		# Travel down the subvalue list to get the value
		var this_value
		while len(sub_values) > 0:
			if this_value == null:
				this_value = source.get(sub_values[0])
				sub_values.pop_front()
			else:
				this_value = this_value.get(sub_values[0])
				sub_values.pop_front()
	
		real_values.append(this_value)
	
	var real_text:String = text_format
	
	for i in range(len(values)):
		real_text = real_text.replace("{" + str(i) + "}", str(real_values[i]))
	
	me.text = real_text
	
