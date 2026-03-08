class_name LevelLayout


var _player_start: Vector2i = Vector2i.ZERO
var _tile_layers: TileLayers = TileLayers.new()


func add_tile_to_layer(tx: int, ty: int, lt: TileLayers.LayerType) -> void:
	_tile_layers.add_coord(Vector2i(tx, ty), lt)

#the only time we use get is while setting up the level
func get_tiles_for_layer(lt: TileLayers.LayerType) -> Array[Vector2i]:
	return _tile_layers.get_tiles_for_layer(lt)

func clearImmovableWalls():
	_tile_layers.clearImmovableWalls()

func pick_random() -> void:
	var wallLayer: Array[Vector2i]= _tile_layers.get_tiles_for_layer(TileLayers.LayerType.Walls).duplicate(true)
	var size = wallLayer.size()
	var random_key = wallLayer[randi() % size]
	wallLayer.erase(random_key)
	_tile_layers.add_coord(random_key, TileLayers.LayerType.ImmovableWalls)
