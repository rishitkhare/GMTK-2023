extends Node

@onready var character : CharacterBody2D
@onready var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func register_character(_character : CharacterBody2D):
	self.character = _character

func register_camera(_camera : Camera2D):
	self.camera = _camera
