extends Control

@onready var map : Panel = $Panel
@onready var tilemaps : Node2D = get_tree().current_scene.get_node("Tilemaps")
var totalWidth : float
var totalHeight : float
var topleftcorner : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	grabDimensions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Panel/characterPosMarker.position = _coord_transform(GameManager.car.position)
	# print($characterPosMarker.position)

func _coord_transform(car_pos : Vector2) -> Vector2:
	var uv = Vector2((car_pos.x - topleftcorner.x) / totalWidth, (car_pos.y - topleftcorner.y) / totalHeight)
	
	return Vector2(uv.x * map.size.x, uv.y * map.size.y)

func grabDimensions():
	var mostleft = null
	var mostright = null
	var mosttop = null
	var mostbottom = null
	for tilemap in tilemaps.get_children():
		var map_rect = tilemap.get_used_rect()
		
		# proceeds to perform the gayest ass coordinate space transformation
		var start = tilemap.to_global(tilemap.map_to_local(map_rect.position) - (0.5*tilemap.tile_set.tile_size))
		var end = tilemap.to_global(tilemap.map_to_local(map_rect.end) - (0.5*tilemap.tile_set.tile_size))
		print(end)
		
		if(!mostleft || mostleft > start.x):
			mostleft = start.x
		if(!mosttop || mosttop > start.y):
			mosttop = start.y
		if(!mostright || mostright < end.x):
			mostright = end.x
		if(!mostbottom || mostbottom < end.y):
			mostbottom = end.y
			
	print(mostright)
	totalWidth = mostright - mostleft
	totalHeight = mosttop - mostbottom
	if(totalWidth > totalHeight):
		totalHeight = totalWidth
	elif(totalHeight > totalWidth):
		totalWidth = totalHeight
	topleftcorner = Vector2(mostleft, mosttop)
