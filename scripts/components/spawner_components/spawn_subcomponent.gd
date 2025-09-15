extends Component
class_name SpawnerSubComponent

@onready var component:SpawnerComponent = get_parent()

func _ready() -> void:
	actor = component.actor
