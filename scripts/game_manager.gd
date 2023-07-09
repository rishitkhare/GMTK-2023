extends Node

enum INSTRUCTION {IDLE, S_UP, S_DN, TURN_R, TURN_L}

signal level_reset

@onready var car : CharacterBody2D
@onready var camera : Camera2D
@onready var instructs = []
@onready var rage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
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
	print("rage added " + str(_rage))
	rage += _rage
	rage = clampf(rage, 0, 1)
	UI.get_node("RageMeter").set_rage_value(rage)

func get_random_int(max_int_excl : int) -> int :
	return randi() % max_int_excl
	
func get_random_float() -> float :
	return randf()
	

func car_crashed():
	print("reset level")
	emit_signal("level_reset")

