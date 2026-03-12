extends Node

const LEVEL_DATA_PATH_START:String="res://Data/level_data"
const LEVEL_DATA_PATH_END:String=".txt"
const NUM_OF_LEVELS:int=2  #hard coded need to change after competition
#hard code random data because almost out of time
var immovableWalls:Array[int]= [3,6]
var removeWalls:Array[int]= [3,6]

var _level_data:Dictionary={}

func _enter_tree() -> void:
	load_level_data()

func setup_level(file:FileAccess)->LevelLayout:
	var layout:LevelLayout = LevelLayout.new()
	var y := 0
	var test:String=file.get_as_text()
	while !file.eof_reached():
		var line:String = file.get_line()
		for x in range(line.length()):
			var c = line[x]
			match c:
				".":
					layout.add_tile_to_layer(x, y, TileLayers.LayerType.Floor)
				"#":
					layout.add_tile_to_layer(x, y, TileLayers.LayerType.Walls)
				"p":
					layout.add_tile_to_layer(x, y, TileLayers.LayerType.Floor)
					layout.set_player_start(x, y)
		y+=1
	return layout


func load_level_data()->void:
	for n in range(1, NUM_OF_LEVELS + 1):
		var level_path=LEVEL_DATA_PATH_START+str(n)+LEVEL_DATA_PATH_END
		var file:FileAccess=FileAccess.open(level_path,FileAccess.READ)
		if !file:
			return

		_level_data[n] = setup_level(file)

func reset_level_data(levelNum:int):
	var level_path=LEVEL_DATA_PATH_START+str(levelNum)+LEVEL_DATA_PATH_END
	var file:FileAccess=FileAccess.open(level_path,FileAccess.READ)
	if !file:
		return
	assert(file, "File not found")
	_level_data[levelNum]=setup_level(file)

func get_level_data(levelNum:int)->LevelLayout:
	var temp:LevelLayout=_level_data[levelNum]
	temp.clearImmovableWalls()
	for n in range(immovableWalls[levelNum-1]):
		temp.pick_random()
	return _level_data[levelNum]
