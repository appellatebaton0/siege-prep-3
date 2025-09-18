extends Node

signal game_lost

@onready var world:Node2D = get_tree().get_first_node_in_group("Main")

var score:int = 0
var best:int = 0

func _ready() -> void:
	game_lost.connect(_on_game_lost)

func _on_game_lost():
	
	if score > best:
		best = score
	
	score = 0

var global_animations:Array[GlobalAnimation]
func add_global_animation(additor:GlobalAnimation):
	if not global_animations.has(additor):
		global_animations.append(additor)

func _process(delta: float) -> void:
	
	for animation in global_animations:
		animation.frame_timer += delta
		
		if animation.frame_timer >= (1 / animation.fps):
			animation.current_frame += 1
			animation.frame_timer = 0.0
			
			if animation.current_frame >= len(animation.frames):
				animation.current_frame = 0
