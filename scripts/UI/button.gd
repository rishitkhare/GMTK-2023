extends Button

@onready var draggable = get_node("../../../../DraggableButton")

func _on_pressed():
	draggable.start_dragging(self)
