extends CharacterBody2D
enum mSTATE {IDLE, WAITING, EXECUTING}
enum tSTATE {PRE, LEG1, LEG2, NONE}

@export var waitTimeMid : float = 1.0
@export var waitTimeVar : float = 0.2
@export var speedUpAmt : float = 0.0
@export var speedDnAmt : float = 0.0
@export var startDir : Vector2 = Vector2(0, 0)
@export var incorTurnPenalty : float = 10
@export var turnDistance : float = 100
@onready var rng = RandomNumberGenerator.new()
@onready var timer : float = 0.0
@onready var curInst : GameManager.INSTRUCTION
@onready var curDir : Vector2 = startDir
@onready var mvelocity : Vector2 = Vector2(0,0)
@onready var state : mSTATE = mSTATE.IDLE
@onready var rc_f : RayCast2D = $Raycasts/Farther
@onready var rc_c : RayCast2D = $Raycasts/Closer
@onready var a1 : RayCast2D = $Raycasts/Anger1
@onready var a2 : RayCast2D = $Raycasts/Anger2
@onready var a3 : RayCast2D = $Raycasts/Anger3
@onready var temp : float = 0
@onready var tstate : tSTATE = tSTATE.NONE
@onready var speedUpAm  : float = speedUpAmt
@onready var speedDnAm : float = speedDnAmt

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
		if(tstate == tSTATE.PRE):
			temp = turnDistance / mvelocity.length()
			if(getCollisionState() == 0):
				tstate = tSTATE.LEG1
				if(curInst == GameManager.INSTRUCTION.TURN_L):
					temp = temp * 1.7
		if(tstate == tSTATE.LEG1):
			temp -= delta
			if(temp <= 0):
				tstate = tSTATE.LEG2
				if(curInst == GameManager.INSTRUCTION.TURN_L):
					curDir = Vector2(curDir.y, curDir.x)
					mvelocity = Vector2(mvelocity.y, mvelocity.x)
					self.rotation_degrees -= 90
				elif(curInst == GameManager.INSTRUCTION.TURN_R):
					curDir = -1 * Vector2(curDir.y, curDir.x)
					mvelocity = -1 * Vector2(mvelocity.y, mvelocity.x)
					self.rotation_degrees += 90
				temp = 0
		if(tstate == tSTATE.LEG2):
			if(getCollisionState() == 5):
				tstate = tSTATE.NONE
				state = mSTATE.IDLE
	self.position.x += mvelocity.x
	self.position.y += mvelocity.y	
	#update range stuff
	waitTimeMid = 1 + GameManager.rage*2
	waitTimeVar = GameManager.rage*2
	speedUpAm = speedUpAmt + speedUpAmt*GameManager.rage
	speedDnAm = speedDnAmt - speedDnAmt*GameManager.rage

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
		mvelocity += curDir * speedUpAm
		state = mSTATE.IDLE
	elif(curInst == GameManager.INSTRUCTION.S_DN):
		mvelocity -= curDir * speedDnAm
		if(mvelocity.angle_to(curDir) != 0):
			mvelocity = Vector2(0,0)
		state = mSTATE.IDLE		
	elif(curInst == GameManager.INSTRUCTION.TURN_R):
		if(state == mSTATE.WAITING):
			var goodness = getCollisionState()
			GameManager.add_rage(add_turn_rage(goodness))
			if(goodness == 5 || goodness == 0):
				GameManager.time_penalty(incorTurnPenalty)
				state = mSTATE.IDLE
			else:
				state = mSTATE.EXECUTING
				tstate = tSTATE.PRE
	elif(curInst == GameManager.INSTRUCTION.TURN_L):
		if(state == mSTATE.WAITING):
			var goodness = getCollisionState()
			GameManager.add_rage(add_turn_rage(goodness))
			if(goodness == 5 || goodness == 0):
				GameManager.time_penalty(incorTurnPenalty)
				state = mSTATE.IDLE
			else:
				state = mSTATE.EXECUTING
				tstate = tSTATE.PRE
	return true	 
func getCollisionState() -> int:
	if(rc_c.is_colliding()):
		return 0 # you've gone too far
	elif(a3.is_colliding()):
		return 1
	elif(a2.is_colliding()):
		return 2
	elif(a1.is_colliding()):
		return 3
	elif(rc_f.is_colliding()):
		return 4
	else:
		return 5 # not close enough
func add_turn_rage(good : int) -> float:
	match(good):
		0:
			print("turn missed")
			return 0.2
		1:
			print("turn missed")
			return 0.1
		2:
			return 0.0
		3: 
			return 0.0
		4:
			return 0.1
		5:
			return 0.2
			
	push_error("defaulted match statement")
	return -1
	
