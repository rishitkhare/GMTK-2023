extends Camera2D

@onready var velocity : Vector2 = Vector2.ZERO
@export var DRAG_FACTOR = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.register_camera(self)
