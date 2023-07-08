extends Button

@onready var draggableParent = get_node("../../../../")
const draggableButton = preload("res://Scenes/UI/draggable_button.tscn")

func _on_pressed():
	var new_drag = draggableButton.instantiate()
	draggableParent.add_child(new_drag)
	
	new_drag.start_dragging(self)
