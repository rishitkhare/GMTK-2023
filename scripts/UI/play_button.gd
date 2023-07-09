extends Button

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level01.tscn")
	
	UI.get_node("RageMeter").show()
	UI.get_node("DriverControls").show()
	
	UI.get_node("RageMeter").set_process_input(true)
	UI.get_node("DriverControls").set_process_input(true)
