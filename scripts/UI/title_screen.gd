extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	# hide game UI on title screen
	for ui_node in UI.get_children():
		ui_node.hide()
		ui_node.set_process_input(false)
