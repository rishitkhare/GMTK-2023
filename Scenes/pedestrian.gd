extends AnimatedSprite2D

enum PedestrianState {IDLE, WALK}

@export var npc_name : String = "01"
@export var state : PedestrianState = PedestrianState.IDLE:
	set(value):
		state = value
		update_animation()

@export var direction : Vector2 = Vector2.DOWN:
	set(value):
		direction = value
		update_animation()
		
func update_animation():
	var animation_name = npc_name + "_"
	match(state):
		PedestrianState.IDLE:
			animation_name = animation_name + "idle_"
		PedestrianState.WALK:
			animation_name = animation_name + "walk_"
	
	match(direction):
		Vector2.DOWN:
			animation_name = animation_name + "down"
			flip_h = false
		Vector2.UP:
			animation_name = animation_name + "up"
			flip_h = false
		Vector2.LEFT:
			animation_name = animation_name + "side"
			flip_h = false
		Vector2.RIGHT:
			animation_name = animation_name + "side"
			flip_h = true
	
	play(animation_name)


func _on_area_2d_body_entered(body):
	if body == GameManager.car:
		GameManager.car_crashed()
