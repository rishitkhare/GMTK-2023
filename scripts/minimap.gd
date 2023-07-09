extends Node2D

@onready var map : Panel = $Panel
@onready var tilemaps : Node2D = $TileMaps
@export var Player : CharacterBody2D
var totalWidth : float
var totalHeight : float
var center : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	grabDimensions()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.position = _coord_transform(Player.position)	

func _coord_transform(car_pos : Vector2) -> Vector2:
	var x_trans = map.size.x / totalWidth
	var y_trans = map.size.y / totalHeight
	var x_raw = (car_pos.x - center.x) * x_trans
	var y_raw = (car_pos.y - center.y) * y_trans
	return Vector2(x_raw + map.position.x, y_raw + map.position.y)

func grabDimensions():
	var mostleft = 0
	var mostright = 0
	var mosttop = 0
	var mostbottom = 0
	for tile in tilemaps.get_children():
		var rect = tile.get_used_rect()
		if(mostleft > rect.position.x):
			mostleft = rect.position.x
		if(mostbottom > rect.position.y):
			mostbottom = rect.position.y
		if(mostright < rect.end.x):
			mostright = rect.end.x
		if(mosttop < rect.end.y):
			mosttop = rect.end.y
	totalWidth = mostright - mostleft
	totalHeight = mosttop - mostbottom
	if(totalWidth > totalHeight):
		totalHeight = totalWidth
	elif(totalHeight > totalWidth):
		totalWidth = totalHeight
	center = Vector2(mostleft + (totalWidth / 2), mostbottom + (totalHeight / 2))
