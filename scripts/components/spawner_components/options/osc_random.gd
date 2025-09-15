extends OptionsSpawnerComponent
class_name RandomOptionsSpawnerComponent

## Actor spawn options.
@export var options:Array[PackedScene]

func get_options() -> Array[PackedScene]:
	return [options.pick_random()]
