class_name TileLayers


enum LayerType { NULL,Floor, Walls, ImmovableWalls}


var _floor: Array[Vector2i]
var _wall: Array[Vector2i]
var _immovable_wall: Array[Vector2i]


var _layer_coords: Dictionary = {
	LayerType.Floor: _floor,
	LayerType.Walls: _wall,
	LayerType.ImmovableWalls: _immovable_wall
}
func clearImmovableWalls():
	_immovable_wall.clear()

func add_coord(coord: Vector2i, lt: LayerType) -> void:
	if(lt==LayerType.NULL):return
	_layer_coords[lt].push_back(coord)
	pass

func remove_coord(coord: Vector2i, lt: LayerType) -> void:
	_layer_coords[lt].erase(coord)
	pass


func get_tiles_for_layer(lt: LayerType) -> Array[Vector2i]:
	return _layer_coords[lt]
