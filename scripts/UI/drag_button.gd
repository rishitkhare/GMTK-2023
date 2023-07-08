extends Control

@onready var dragging = false
@onready var to_slot = false
@onready var to_slot_frame = 20
@onready var selected = null
@onready var slot_position = get_node("../Slot/Anchor").global_position

func _input(event):
	# handle dragging motion (maybe add rotation for fun?)
	if dragging && event is InputEventMouseMotion:
		position += event.relative
		rotation += 0.01 * event.relative.x
	
	# handles when to turn "dragging" off
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if dragging && event.pressed == true:
			if (position - slot_position).length_squared() < 5625:
				dragging = false
				to_slot = true
				to_slot_frame = 20
			else:
				stop_dragging()

func _process(_delta):
	rotation *= 0.85 # decel constant
	rotation = clampf(rotation, -PI/4, PI/4)

	
	if to_slot:
		position += 0.06 * (slot_position - position)
		modulate = Color(modulate.r + 0.1, modulate.r + 0.1, modulate.r + 0.1, modulate.a - 0.03)
		to_slot_frame -= 1
		if (slot_position - position).length_squared() < 5 && to_slot_frame < 1:
			match(selected.text):
				"Speed up!":
					GameManager.add_instruct(GameManager.INSTRUCTION.S_UP)
				"Turn left!":
					GameManager.add_instruct(GameManager.INSTRUCTION.TURN_L)
				"Stop!":
					GameManager.add_instruct(GameManager.INSTRUCTION.S_DN)
				"Turn right!":
					GameManager.add_instruct(GameManager.INSTRUCTION.TURN_R)
			stop_dragging()
			modulate = Color(1,1,1,1)
			to_slot = false

func start_dragging(button):
	if !dragging && !to_slot:
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
