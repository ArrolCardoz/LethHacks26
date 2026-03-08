extends Node2D
class_name AddAndRemoveTile

@export var _tile_map_layer:TileMapLayer

const SOURCE_ID=0
const TILE_MAP_IS_EMPTY=-1

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !_tile_map_layer:
			return

		var cell_pos:Vector2i=_tile_map_layer.local_to_map(_tile_map_layer.to_local(get_global_mouse_position()))

		if _tile_map_layer.get_cell_source_id(cell_pos)!= TILE_MAP_IS_EMPTY:
			_tile_map_layer.set_cell(cell_pos,-1)
		else:
			var atlas_coords:Vector2i=Vector2i(randi_range(1,4),0)
			_tile_map_layer.set_cell(cell_pos,SOURCE_ID,atlas_coords)
