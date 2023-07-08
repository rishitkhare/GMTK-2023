extends Control

@onready var dragging = false
@onready var selected = null

func _input(event):
	# handle dragging motion (maybe add rotation for fun?)
	if dragging && event is InputEventMouseMotion:
		position += event.relative
		rotation += 0.005 * event.relative.x
		
	
	# handles when to turn "dragging" off
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if dragging && event.pressed == true:
			stop_dragging()

func _process(_delta):
	rotation *= 0.9 # decel constant
	rotation = clampf(rotation, -45, 45)

func start_dragging(button):
	selected = button
	dragging = true
	position = selected.global_position - $Button.position
	
	$Button.text = selected.text
	visible = true
	
func stop_dragging():
	selected = null
	dragging = false
	
	$Button.text = "not visible"
	visible = false
