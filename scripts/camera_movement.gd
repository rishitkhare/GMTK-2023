extends Camera2D

@onready var velocity : Vector2 = Vector2.ZERO
@export var max_offset = 1.0
@export var camer_accel_decel = 0.05
@onready var car = GameManager.car

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if car == null:
		car = GameManager.car
		return #bro
		
	if car.mvelocity == Vector2.ZERO:
		pass
	
#	if velocity.y < 0 and self.position.y < target_position.y or\
#	   velocity.y > 0 and self.position.y > target_position.y:
#		self.position.y = target_position.y
#	if velocity.x < 0 and self.position.x < target_position.x or\
#	   velocity.x > 0 and self.position.x > target_position.x:
#		self.position.x = target_position.x
