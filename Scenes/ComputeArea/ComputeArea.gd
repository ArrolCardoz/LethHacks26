extends Node2D
class_name ComputeArea

@export var _wall_tile_map_layer:TileMapLayer



func _ready() -> void:
	SignalHub.connect("compute_area",compute_area)


func compute_area() -> bool:
	print("area")

	var rect = _wall_tile_map_layer.get_used_rect()
	# expand bounds so we start outside the walls
	print(rect.position)

	rect.position -= Vector2i.ONE
	rect.size += Vector2i(2,2)
	print(rect.position)
	var visited = {}
	var queue = [rect.position]

	while queue.size() > 0:
		var pos = queue.pop_front()
		print(pos)
		if visited.has(pos):
			continue
		# skip walls
		if _wall_tile_map_layer.get_cell_source_id(pos) != -1:
			continue
		visited[pos] = true
		for d in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
			var n = pos + d
			if n.x < rect.position.x or n.x >= rect.position.x + rect.size.x:
				continue
			if n.y < rect.position.y or n.y >= rect.position.y + rect.size.y:
				continue
			if !visited.has(n):
				queue.append(n)

	# count interior empty cells
	var area = 0
	for x in range(rect.position.x + 1, rect.position.x + rect.size.x - 1):
		for y in range(rect.position.y + 1, rect.position.y + rect.size.y - 1):
			var pos = Vector2i(x,y)
			if _wall_tile_map_layer.get_cell_source_id(pos) == -1 and !visited.has(pos):
				area += 1
	rect.size -= Vector2i(2,2)
	print((rect.size.x*rect.size.y)-queue.size())
	print(rect.size.x)
	print(rect.size.y)
	print(area)

	return area
