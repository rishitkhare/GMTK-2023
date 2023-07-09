extends Node2D

@export var StopTime : float = 0.01
@export var violationPenalty : float = 100
@onready var Player : CharacterBody2D = GameManager.car
@onready var StopTimer : float = 0.0
@onready var area : Area2D = $Area2D
@onready var entered : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(area.overlaps_body(Player) && entered == false):
		entered = true
		print("entered")
	elif(entered == true && !area.overlaps_body(Player)):
		entered = false
		print("exited")
		if(StopTimer < StopTime):
			GameManager.time_penalty(violationPenalty)
		StopTimer = 0
	elif(entered == true && Player.mvelocity.length() == 0):
		StopTimer += delta
	elif(entered == true && Player.mvelocity.length() != 0):
		StopTimer = 0
	
