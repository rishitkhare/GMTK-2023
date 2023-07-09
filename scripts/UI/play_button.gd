extends Button

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level01.tscn")
	
	for ui_node in UI.get_children():
		ui_node.show()
		ui_node.set_process_input(true)
