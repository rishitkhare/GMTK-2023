extends Node

enum INSTRUCTION {IDLE, S_UP, S_DN, TURN_R, TURN_L}

signal level_reset

const LVL_COUNT = 3
const WIN_SCENE_PATH = "res://Scenes/Win.tscn"

@onready var car : CharacterBody2D
@onready var camera : Camera2D
@onready var instructs = []
@onready var rage = 0
@onready var time_remaining = 0
@onready var timer_enabled = false
@onready var level_index = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func _process(delta):
	if timer_enabled:
		time_remaining -= delta
		
		UI.get_node("Timer/Timestamp").text = str(floor(time_remaining))
		
		if time_remaining < 0:
			reset_level()
	
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
	time_remaining -= penalty
	
func add_rage(_rage : float):
	rage += _rage
	rage = clampf(rage, 0, 1)
	UI.get_node("RageMeter").set_rage_value(rage)
	
func set_rage(_rage : float):
	rage = _rage
	rage = clampf(rage, 0, 1)
	UI.get_node("RageMeter").set_rage_value(rage)

func get_random_int(max_int_excl : int) -> int :
	return randi() % max_int_excl
	
func get_random_float() -> float :
	return randf()

func car_crashed():
	print("reset level")
	emit_signal("level_reset")
	reset_level()
	
func reset_level():
	set_rage(0)
	instructs.clear()
	time_remaining = 0
	timer_enabled = false
	get_tree().reload_current_scene()
	
# does not allow for more than 9 lvls
func win():
	level_index += 1
	
	if level_index > LVL_COUNT:
		get_tree().change_scene_to_file(WIN_SCENE_PATH)
		
		for ui_node in UI.get_children():
			ui_node.hide()
			ui_node.set_process_input(false)
		
	else:
		var new_scene_path = "res://Scenes/Levels/level0" + str(level_index) + ".tscn"
		
		get_tree().change_scene_to_file(new_scene_path)
	

