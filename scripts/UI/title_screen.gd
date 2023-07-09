extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	# hide game UI on title screen
	UI.get_node("RageMeter").hide()
	UI.get_node("DriverControls").hide()
	
	UI.get_node("RageMeter").set_process_input(false)
	UI.get_node("DriverControls").set_process_input(false)
