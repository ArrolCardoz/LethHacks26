extends Node2D

@onready var floor_tiles: TileMapLayer = $TileLayers/Floor
@onready var walls_tiles: TileMapLayer = $TileLayers/Walls
@onready var tile_layers: Node2D = $TileLayers
@onready var camera: Camera2D = $Camera

const SOURCE_ID=0

var _tile_size:int=0
var _player_position=Vector2i.ZERO
var _game_over:bool=false
var _level_num:int=9999
var _moves_made:int=0


func _ready() -> void:
	_tile_size=floor_tiles.tile_set.tile_size.x
	setup_level()

func get_atlas_coord(tileType:TileLayers.LayerType)->Vector2i:
	match(tileType):
		TileLayers.LayerType.Floor:
			var x:int=randi_range(6,9)
			var y:int=randi_range(0,2)
			return Vector2i(x,y)
		TileLayers.LayerType.Walls:
			return Vector2i(randi_range(1,4),0)
		_:
			return Vector2i.ZERO

func add_tile(tileType:TileLayers.LayerType,coord:Vector2i,map:TileMapLayer)->void:
	var atlas_coord:Vector2i=get_atlas_coord(tileType)
	map.set_cell(coord,SOURCE_ID,atlas_coord)

func setup_layer(tileType:TileLayers.LayerType,map:TileMapLayer,layout:LevelLayout)->void:
	var tiles:Array[Vector2i]=layout.get_tiles_for_layer(tileType)
	for tileCoords in tiles:
		add_tile(tileType,tileCoords,map)



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		GameManager.load_main_scene()
	elif event.is_action_pressed("Reload"):
		get_tree().reload_current_scene()
	if _game_over:return





func cellIsWall(playerPos:Vector2i)->bool:
	return playerPos in walls_tiles.get_used_cells()


func setup_level()->void:
	_level_num=GameManager._level_selected
	var level_layout:LevelLayout=LevelData.get_level_data(_level_num)
	for TileLaysChildern in tile_layers.get_children():
		TileLaysChildern.clear()
	setup_layer(TileLayers.LayerType.Floor,floor_tiles,level_layout)
	setup_layer(TileLayers.LayerType.Walls,walls_tiles,level_layout)
	setupCam(floor_tiles)
	#game_ui.incrementMoves(_moves_made)



func setupCam(floorTile:TileMapLayer)->void:
	var coords=floorTile.get_used_rect()
	camera.position=coords.get_center()*_tile_size
