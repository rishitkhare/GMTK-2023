extends Node2D

@onready var green_light_texture = load("res://sprites/green_light.png")
@onready var yellow_light_texture = load("res://sprites/yellow_light.png")
@onready var red_light_texture = load("res://sprites/red_light.png")

enum LIGHT_STATES {
	GREEN_LIGHT,
	YELLOW_LIGHT,
	RED_LIGHT
}
@onready var light_state = LIGHT_STATES.RED_LIGHT
@onready var LIGHT_TEXTURES = {
	LIGHT_STATES.GREEN_LIGHT : green_light_texture,
	LIGHT_STATES.YELLOW_LIGHT : yellow_light_texture,
	LIGHT_STATES.RED_LIGHT : red_light_texture
}
@export var LIGHT_TIMINGS = {
	LIGHT_STATES.GREEN_LIGHT : 3,
	LIGHT_STATES.YELLOW_LIGHT : 2,
	LIGHT_STATES.RED_LIGHT : 3
}
@onready var light_state_timer : float

@onready var car = GameManager.car
@onready var obstruction_area = $ObstructionArea
@onready var punished = false
@export var traffic_light_violation : float = 110
@export var added_rage : float = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	var starting_texture
	light_state = LIGHT_STATES.GREEN_LIGHT if GameManager.get_random_int(2) \
										   else LIGHT_STATES.RED_LIGHT
	$Sprite2D.set_texture(LIGHT_TEXTURES.get(light_state))
	light_state_timer = GameManager.get_random_float() * LIGHT_TIMINGS.get(light_state)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not punished and obstruction_area.overlaps_body(car):
		if light_state == LIGHT_STATES.RED_LIGHT or car.mvelocity == Vector2.ZERO:
			GameManager.time_penalty(traffic_light_violation)
			GameManager.add_rage(added_rage)
			punished = true
	
	if light_state_timer >= LIGHT_TIMINGS.get(light_state):
		light_state_timer = 0
		light_state += 1
		light_state %= 3
		$Sprite2D.set_texture(LIGHT_TEXTURES.get(light_state))
	light_state_timer += delta
		
