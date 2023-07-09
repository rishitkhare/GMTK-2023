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
@onready var LIGHT_TIMINGS = {
	LIGHT_STATES.GREEN_LIGHT : 4,
	LIGHT_STATES.YELLOW_LIGHT : 2,
	LIGHT_STATES.RED_LIGHT : 3
}

@onready var player = GameManager.car
@onready var area = $Area2D
@onready var need_to_stop = false
@export var red_light_violation_penalty : float = 110
@export var added_rage : float = 0.25

@onready var light_state_timer : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var starting_texture
	if GameManager.get_random_int(2):
		$Sprite2D.set_texture(LIGHT_TEXTURES.get(LIGHT_STATES.GREEN_LIGHT))
	else:
		$Sprite2D.set_texture(LIGHT_TEXTURES.get(LIGHT_STATES.RED_LIGHT))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if area.overlaps_body(player) and light_state == LIGHT_STATES.RED_LIGHT:
		need_to_stop = true
	if need_to_stop and not area.overlaps_body(player):
		GameManager.time_penalty(red_light_violation_penalty)
		GameManager.add_rage(added_rage)
	
	if light_state_timer >= LIGHT_TIMINGS.get(light_state):
		light_state_timer = 0
		light_state += 1
		light_state %= 3
		$Sprite2D.set_texture(LIGHT_TEXTURES.get(light_state))
	light_state_timer += delta
		
