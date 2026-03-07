extends Control
"""
const NUM_OF_LEVELS=30

const LEVEL_BUTTON = preload("res://Scenes/LevelButton/LevelButton.tscn")

@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	setupButtons()

func setupButtons()->void:
	for levelNum in range(NUM_OF_LEVELS):
		var newButton:LevelButton=LEVEL_BUTTON.instantiate()
		newButton.setLevelNum( str(levelNum+1))
		grid_container.add_child(newButton)
	"""
