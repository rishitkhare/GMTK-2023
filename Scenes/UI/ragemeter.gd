extends Control

@onready var value = 0
@onready var smoothed = 0

func _process(delta):
	smoothed += 0.2 * (value - smoothed)
	$ProgressBar.value = smoothed

func set_rage_value(val : float):
	value = val
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_T:
			set_rage_value(0)
		elif event.keycode == KEY_Y:
			set_rage_value(0.5)
		elif event.keycode == KEY_U:
			set_rage_value(1)
		
