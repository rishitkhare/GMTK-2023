extends Camera2D

@onready var velocity : Vector2 = Vector2.ZERO
@export var DRAG_FACTOR = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.register_camera(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var target_position : Vector2 = GameManager.character.position
	#var distance_left : Vector2 = target_position - self.position
	#velocity = distance_left.normalized() * distance_left.length() * DRAG_FACTOR
	#self.position += velocity
	#self.position = GameManager.car.position
	
	
