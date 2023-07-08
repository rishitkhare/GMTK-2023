extends CharacterBody2D
enum mSTATE {IDLE, WAITING, EXECUTING}

@export var waitTimeMid : float = 1.0
@export var waitTimeVar : float = 0.2
@export var speedUpAmt : float = 0.0
@export var speedDnAmt : float = 0.0
@export var startDir : Vector2 = Vector2(0, 0)
@onready var rng = RandomNumberGenerator.new()
@onready var timer : float = 0.0
@onready var curInst : GameManager.INSTRUCTION
@onready var curDir : Vector2 = startDir
@onready var mvelocity : Vector2 = Vector2(0,0)
@onready var state : mSTATE = mSTATE.IDLE
@onready var rc_f : RayCast2D = $Raycasts/Farther
@onready var rc_c : RayCast2D = $Raycasts/Closer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.register_car(self)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(state == mSTATE.WAITING):
		if(timer <= 0.0):
			_execute_current()
		else:
			timer -= delta
	elif(state == mSTATE.IDLE):
		_process_instruct(GameManager.grab_next_instruct())
	elif(state == mSTATE.EXECUTING):
		pass
	self.position.x += mvelocity.x
	self.position.y += mvelocity.y	

func _process_instruct(instruct : GameManager.INSTRUCTION):
	curInst = instruct
	timer = rng.randf_range(waitTimeMid - waitTimeVar, waitTimeMid + waitTimeVar)
	if(instruct == GameManager.INSTRUCTION.IDLE):
		timer = 0.0
		state = mSTATE.IDLE
	else:
		state = mSTATE.WAITING

func _execute_current() -> bool:
	if(curInst == GameManager.INSTRUCTION.IDLE):
		return false
	elif(curInst == GameManager.INSTRUCTION.S_UP):
		mvelocity += curDir * speedUpAmt
	elif(curInst == GameManager.INSTRUCTION.S_DN):
		mvelocity -= curDir * speedDnAmt
		if(mvelocity.angle_to(curDir) != 0):
			mvelocity = Vector2(0,0)
			
	elif(curInst == GameManager.INSTRUCTION.TURN_R):
		if(state == mSTATE.WAITING):
			state = mSTATE.EXECUTING
	return true

func getCollisionState() -> int:
	if(rc_c.is_colliding() && rc_f.is_colliding()):
		return 2 # you've gone too far
	elif(rc_f.is_colliding()):
		return 1 # you're in the sweet spot
	else:
		return 0 # not close enough
