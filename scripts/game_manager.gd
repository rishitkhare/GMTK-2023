extends Node

enum INSTRUCTION {IDLE, S_UP, S_DN, TURN_R, TURN_L}

@onready var car : CharacterBody2D
@onready var camera : Camera2D
@onready var instructs = []
@onready var rage = 0

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clampf(rage, 0, 1)
	
func register_car(_car : CharacterBody2D):
	self.car = _car

func register_camera(_camera : Camera2D):
	self.camera = _camera
func register_character(_char : CharacterBody2D):
	pass
func add_instruct(instruct : INSTRUCTION):
	instructs.append(instruct)
	
func grab_next_instruct()  -> INSTRUCTION:
	if(instructs.size() == 0):
		return INSTRUCTION.IDLE
	else:
		return instructs.pop_front()

func time_penalty(penalty : float):
	print("penalty")
	
func add_rage(_rage : float):
	rage += _rage
	


