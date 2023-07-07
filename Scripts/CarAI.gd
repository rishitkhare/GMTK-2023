extends Node2D
@export var waitTimeMid : float = 1.0
@export var waitTimeVar : float = 0.2
@export var rightTurn_range : Vector2 = Vector2(0.0, 0.0)
@export var leftTurn_range : Vector2 = Vector2(0.0, 0.0)
@onready var rng = RandomNumberGenerator.new()
@onready var timer : float = 0.0
@onready var curInst : GameManager.INSTRUCTION

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Todo: Register with game manager
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timer <= 0.0):
		_execute_current()
		_process_instruct(GameManager.grab_next_instruct())
	else: 
		timer -= delta;

func _process_instruct(instruct : GameManager.INSTRUCTION):
	curInst = instruct
	timer = rng.randf_range(waitTimeMid - waitTimeVar, waitTimeMid + waitTimeVar)

func _execute_current() -> bool:
	if(curInst == GameManager.INSTRUCTION.IDLE):
		return false
	return true
