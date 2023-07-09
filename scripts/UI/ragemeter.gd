extends Control

@onready var value = 0
@onready var smoothed = 0
@onready var prog_bar_node = $Panel/ProgressBar

func _process(delta):
	smoothed += 0.1 * (value - smoothed)
	prog_bar_node.value = smoothed + 0.004

func set_rage_value(val : float):
	value = val
	
