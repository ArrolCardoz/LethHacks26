extends Node

signal compute_area()
func emit_compute_area()->void:
	compute_area.emit()
