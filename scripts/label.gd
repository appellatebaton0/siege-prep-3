extends Label
class_name Scorelabel

func _process(delta: float) -> void:
	text = "Score: " + str(Global.score) + " Best: " + str(Global.best)
